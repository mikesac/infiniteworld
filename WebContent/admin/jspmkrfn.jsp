<%!
//-------------------------------------------------------------------------------
// Functions for DEFAULT date format
// ANamedFormat = 0-7, where 0-4 same as VBScript
// 5 = "yyyy/mm/dd"
// 6 = "mm/dd/yyyy"
// 7 = "dd/mm/yyyy"

final String EW_DATE_SEPARATOR = "/";
private static final char c[] = { '<', '>', '&', '\"'};
private static final String expansion[] = {"&lt;", "&gt;", "&amp;", "&quot;"};

public String Join(String[] aryString){
	String str = "";
	if (aryString == null || aryString.length == 0) return str;
	for (int i = 0; i < aryString.length; i++){
		str += aryString[i] + ",";
	}
	str = str.substring(0, str.length() -1);
	return str;
}
public static String HTMLEncode(String s) {
	if (s == null) return "";
	StringBuffer st = new StringBuffer();
	for (int i = 0; i < s.length(); i++) {
		boolean copy = true;
		char ch = s.charAt(i);
		for (int j = 0; j < c.length ; j++) {
			if (c[j]==ch) {
				st.append(expansion[j]);
				copy = false;
				break;
			}
		}
		if (copy) st.append(ch);
	}
	return st.toString();
}


private boolean IsNumeric(Object s){
	try{
		Double.parseDouble((String) s);
		return true;
	}catch (Exception e) {
		return false;
	}
}

private String GetDateFormatString(String dateFormat){
	String format = "";

	if (dateFormat.equals("USDATE")){format = "mm/dd/yyyy";}
	else if (dateFormat.equals("DATE")){format = "yyyy/mm/dd";}
	else if (dateFormat.equals("EURODATE")){format = "dd/mm/yyyy";}
	return format;
}

private boolean IsDate(String s, String dateFormat, Locale locale){
	if (s == null) return true;
	String format = "";
	DateFormat df = DateFormat.getInstance();
	if (dateFormat.equals("USDATE")){format = "MM/dd/yyyy";}
	else if (dateFormat.equals("DATE")){format = "yyyy/MM/dd";}
	else if (dateFormat.equals("EURODATE")){format = "dd/MM/yyyy";}

	try {
		if (format.length() > 0){
			df = new SimpleDateFormat(format, locale);
			((SimpleDateFormat) df).parse(s);
		}else{
			df.parse(s);
		}
		return true;
	}catch(ParseException e) {
		return false;
	}
}


private String EW_FormatDateTime(Object ADate, int ANamedFormat,Locale locale){
	if (ADate == null) return "";
	if (! (ADate instanceof Timestamp)) return ADate.toString();
	SimpleDateFormat formatter;
	DateFormat dateformat;
	Timestamp ts = (Timestamp) ADate;
	String output = "";
	try{

		switch (ANamedFormat){
		case 0:
			dateformat = DateFormat.getDateTimeInstance(DateFormat.SHORT,DateFormat.DEFAULT,locale);
			output = dateformat.format(ts);
			break;
		case 1:
			dateformat = DateFormat.getDateInstance(DateFormat.LONG, locale);
			output = dateformat.format(ts);
			break;
		case 2:
			dateformat = DateFormat.getDateInstance(DateFormat.SHORT, locale);
			output = dateformat.format(ts);
			break;
		case 3:
			dateformat = DateFormat.getTimeInstance(DateFormat.DEFAULT, locale);
			output = dateformat.format(ts);
			break;
		case 4:
			formatter = new SimpleDateFormat("H:k:ss", locale);
			output = formatter.format(ts);
			break;
		case 5:
			formatter = new SimpleDateFormat("yyyy/MM/dd", locale);
			output = formatter.format(ts);
			break;
		case 6:
			formatter = new SimpleDateFormat("MM/dd/yyyy", locale);
			output = formatter.format(ts);
			break;
		case 7:
			formatter = new SimpleDateFormat("dd/MM/yyyy", locale);
			output = formatter.format(ts);
			break;
		default:
			dateformat = DateFormat.getDateTimeInstance(java.text.DateFormat.SHORT,java.text.DateFormat.DEFAULT,locale);
			output = dateformat.format(ts);
			break;
		}
	}catch (Exception e){
		output = "";
	}
	return output;
}

private java.sql.Timestamp EW_UnFormatDateTime(String ADate,String dateFormat, Locale locale){
	if (ADate == null) return null;
	DateFormat df = DateFormat.getInstance();
	String format = "";
	ADate = ADate.trim().replaceAll("  ", " ");

	String [] arDateTime = ADate.split(" ");
	if (arDateTime.length == 0) {
		return null;
	}
	if (dateFormat.equals("USDATE")){format = "MM/dd/yyyy";}
	else if (dateFormat.equals("DATE")){format = "yyyy/MM/dd";}
	else if (dateFormat.equals("EURODATE")){format = "dd/MM/yyyy";}

	try{
		if (format.length() > 0) {
			df = new SimpleDateFormat(format, locale);
			return new java.sql.Timestamp(((SimpleDateFormat) df).parse(ADate).getTime());
		}else{
			return new java.sql.Timestamp(df.parse(ADate).getTime());
		}
	}catch (Exception e){
		return null;
	}
}

private String EW_FormatCurrency(Object obj, int numDigitsAfterDecimal, int includeLeadingDigit,
														int useParensForNegativeNumbers, int groupDigits, Locale locale){
	double value = 0;
	try {
		value = Double.parseDouble((String)obj);
	}catch (Exception e){
		return (String) obj;
	}
	DecimalFormat formatter = (DecimalFormat) DecimalFormat.getCurrencyInstance(locale);
	String pattern = "";

	//formatter.setPositivePrefix("\u00A4\u00A4");
	//formatter.setNegativePrefix("\u00A4\u00A4");

	if (includeLeadingDigit != 0) { pattern = "\u00A40";}else{ pattern = "\u00A4#";}
	if (numDigitsAfterDecimal > 0){
		pattern += ".";
		for (int i = 0; i < numDigitsAfterDecimal; i++){
			pattern += "0";
		}
	}
	if (useParensForNegativeNumbers != 0) {pattern += ";(" + pattern + ")";}
	formatter.applyPattern(pattern);
	if (groupDigits != 0){
		formatter.setGroupingUsed(true);
		formatter.setGroupingSize(3);
	}
	try {
		return formatter.format(value);
	}catch (Exception e){
		return (String) obj;
	}
}

private String EW_FormatNumber(Object obj, int numDigitsAfterDecimal, int includeLeadingDigit,
														int useParensForNegativeNumbers, int groupDigits, Locale locale){
	double value = 0;
	try {
		value = Double.parseDouble((String)obj);
	}catch (Exception e){
		return (String) obj;
	}
	DecimalFormat formatter = (DecimalFormat) DecimalFormat.getNumberInstance(locale);
	String pattern = "";
	if (includeLeadingDigit != 0) { pattern = "0";}else{ pattern = "#";}
	if (numDigitsAfterDecimal > 0){
		pattern += ".";
		for (int i = 0; i < numDigitsAfterDecimal; i++){
			pattern += "0";
		}
	}
	if (useParensForNegativeNumbers != 0) {pattern += ";(" + pattern + ")";}
	formatter.applyPattern(pattern);
	if (groupDigits != 0){
		formatter.setGroupingUsed(true);
		formatter.setGroupingSize(3);
	}
	try {
		return formatter.format(value);
	}catch (Exception e) {
		return (String) obj;
	}
}

private String EW_FormatPercent(Object obj, int numDigitsAfterDecimal, int includeLeadingDigit,
														int useParensForNegativeNumbers, int groupDigits, Locale locale){
	double value = 0;
	try {
		value = Double.parseDouble((String)obj);
	}catch (Exception e){
		return (String) obj;
	}
	DecimalFormat formatter = (DecimalFormat) DecimalFormat.getPercentInstance(locale);
	String pattern = "";
	if (includeLeadingDigit != 0) { pattern = "0";}else{ pattern = "#";}
	if (numDigitsAfterDecimal > 0){
		pattern += ".";
		for (int i = 0; i < numDigitsAfterDecimal; i++){
			pattern += "0";
		}
	}
	pattern += "%";
	if (useParensForNegativeNumbers != 0) {pattern += ";(" + pattern + ")";}
	formatter.applyPattern(pattern);
	if (groupDigits != 0){
		formatter.setGroupingUsed(true);
		formatter.setGroupingSize(3);
	}
	try {
		return formatter.format(value);
	}catch (Exception e) {
		return (String) obj;
	}
}

private String EW_GetFileType(String contentType)
{
	if (contentType.equals("image/gif") || 
			contentType.equals("image/jpeg") ||
			contentType.equals("image/tiff") ||
			contentType.equals("image/x-png"))
	{
		return "image/";				
	}
	else if(contentType.equals("application/pdf") ||
					contentType.equals("application/msword") ||
					contentType.equals("application/mspowerpoint") ||
					contentType.equals("application/ms-excel") ||
					contentType.equals("application/ms-powerpoint") ||
					contentType.equals("application/rtf"))
	{
		return "doc/";
	}
	else
	{
		return "";
	}
}
%>
