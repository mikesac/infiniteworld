// Form Validation JavaScript

function EW_onError(form_object, input_object, object_type, error_message) {
	alert(error_message);									
	if (object_type == "RADIO" || object_type == "CHECKBOX") {
		if (input_object[0])
			input_object[0].focus();
		else
			input_object.focus();
	}	else if (!(document.all && document.all["_"+input_object.name+"_editor"])) { 
		input_object.focus();  
	}  
	if (object_type == "TEXT" || object_type == "PASSWORD" || object_type == "TEXTAREA" || object_type == "FILE") {
		if (!(document.all && document.all["_"+input_object.name+"_editor"]))
			input_object.select();
	}
	return false;	
}

function EW_hasValue(obj, obj_type) {
	if (obj_type == "TEXT" || obj_type == "PASSWORD" || obj_type == "TEXTAREA" || obj_type == "FILE")	{
		if (obj.value.length == 0) 
			return false;
		else if (document.all && document.all["_"+obj.name+"_editor"] && (obj.value == '<P>&nbsp;</P>'))
			return false;  
		else 
			return true;
	}	else if (obj_type == "SELECT") {
		if (obj.type != "select-multiple" && obj.selectedIndex == 0)
			return false;
		else if (obj.type == "select-multiple" && obj.selectedIndex == -1)
			return false;
		else
			return true;
	}	else if (obj_type == "RADIO" || obj_type == "CHECKBOX")	{
		if (obj[0]) {
			for (i=0; i < obj.length; i++) {
				if (obj[i].checked)
					return true;
			}
		} else {
			return (obj.checked);
		}
		return false;	
	}
}

// Date (mm/dd/yyyy)
function EW_checkusdate(object_value) {
	if (object_value.length == 0)
		return true;
	
	isplit = object_value.indexOf('/');
	
	if (isplit == -1 || isplit == object_value.length)
		return false;
	
	sMonth = object_value.substring(0, isplit);
	
	if (sMonth.length == 0)
		return false;
	
	isplit = object_value.indexOf('/', isplit + 1);
	
	if (isplit == -1 || (isplit + 1 ) == object_value.length)
		return false;
	
	sDay = object_value.substring((sMonth.length + 1), isplit);
	
	if (sDay.length == 0)
		return false;
	
	isep = object_value.indexOf(' ', isplit + 1); 
	if (isep == -1) {
		sYear = object_value.substring(isplit + 1);
	} else {
		sYear = object_value.substring(isplit + 1, isep);
		sTime = object_value.substring(isep + 1);
		if (!EW_checktime(sTime))
			return false; 
	}
	
	if (!EW_checkinteger(sMonth)) 
		return false;
	else if (!EW_checkrange(sMonth, 1, 12)) 
		return false;
	else if (!EW_checkinteger(sYear)) 
		return false;
	else if (!EW_checkrange(sYear, 0, 9999)) 
		return false;
	else if (!EW_checkinteger(sDay)) 
		return false;
	else if (!EW_checkday(sYear, sMonth, sDay))
		return false;
	else
		return true;
}

// Date (yyyy/mm/dd)
function EW_checkdate(object_value) {
	if (object_value.length == 0)
		return true;
	
	isplit = object_value.indexOf('/');
	
	if (isplit == -1 || isplit == object_value.length)
		return false;
	
	sYear = object_value.substring(0, isplit);
	
	isplit = object_value.indexOf('/', isplit + 1);
	
	if (isplit == -1 || (isplit + 1 ) == object_value.length)
		return false;
	
	sMonth = object_value.substring((sYear.length + 1), isplit);
	
	if (sMonth.length == 0)
		return false;
	
	isep = object_value.indexOf(' ', isplit + 1); 
	if (isep == -1) {
		sDay = object_value.substring(isplit + 1);
	} else {
		sDay = object_value.substring(isplit + 1, isep);
		sTime = object_value.substring(isep + 1);
		if (!EW_checktime(sTime))
			return false; 
	}
	
	if (sDay.length == 0)
		return false;
	
	if (!EW_checkinteger(sMonth)) 
		return false;
	else if (!EW_checkrange(sMonth, 1, 12)) 
		return false;
	else if (!EW_checkinteger(sYear)) 
		return false;
	else if (!EW_checkrange(sYear, 0, 9999)) 
		return false;
	else if (!EW_checkinteger(sDay)) 
		return false;
	else if (!EW_checkday(sYear, sMonth, sDay))
		return false;
	else
		return true;
}

// Date (dd/mm/yyyy)
function EW_checkeurodate(object_value) {
	if (object_value.length == 0)
	  return true;
	
	isplit = object_value.indexOf('/');
	
	if (isplit == -1)	{
		isplit = object_value.indexOf('.');
	}
	
	if (isplit == -1 || isplit == object_value.length)
		return false;
	
	sDay = object_value.substring(0, isplit);
	
	monthSplit = isplit + 1;
	
	isplit = object_value.indexOf('/', monthSplit);
	
	if (isplit == -1)	{
		isplit = object_value.indexOf('.', monthSplit);
	}
	
	if (isplit == -1 ||  (isplit + 1 )  == object_value.length)
		return false;
	
	sMonth = object_value.substring((sDay.length + 1), isplit);
	
	isep = object_value.indexOf(' ', isplit + 1); 
	if (isep == -1) {
		sYear = object_value.substring(isplit + 1);
	} else {
		sYear = object_value.substring(isplit + 1, isep);
		sTime = object_value.substring(isep + 1);
		if (!EW_checktime(sTime))
			return false; 
	}
	
	if (!EW_checkinteger(sMonth)) 
		return false;
	else if (!EW_checkrange(sMonth, 1, 12)) 
		return false;
	else if (!EW_checkinteger(sYear)) 
		return false;
	else if (!EW_checkrange(sYear, 0, null)) 
		return false;
	else if (!EW_checkinteger(sDay)) 
		return false;
	else if (!EW_checkday(sYear, sMonth, sDay)) 
		return false;
	else
		return true;
}

function EW_checkday(checkYear, checkMonth, checkDay) {
	maxDay = 31;
	
	if (checkMonth == 4 || checkMonth == 6 ||	checkMonth == 9 || checkMonth == 11) {
		maxDay = 30;
	} else if (checkMonth == 2)	{
		if (checkYear % 4 > 0)
			maxDay =28;
		else if (checkYear % 100 == 0 && checkYear % 400 > 0)
			maxDay = 28;
		else
			maxDay = 29;
	}
	
	return EW_checkrange(checkDay, 1, maxDay); 
}

function EW_checkinteger(object_value) {
	if (object_value.length == 0)
		return true;
	
	var decimal_format = ".";
	var check_char;
	
	check_char = object_value.indexOf(decimal_format);
	if (check_char < 1)
		return EW_checknumber(object_value);
	else
		return false;
}

function EW_numberrange(object_value, min_value, max_value) {
	if (min_value != null) {
		if (object_value < min_value)
			return false;
	}
	
	if (max_value != null) {
		if (object_value > max_value)
			return false;
	}
	
	return true;
}

function EW_checknumber(object_value) {
	if (object_value.length == 0)
		return true;
	
	var start_format = " .+-0123456789";
	var number_format = " .0123456789";
	var check_char;
	var decimal = false;
	var trailing_blank = false;
	var digits = false;
	
	check_char = start_format.indexOf(object_value.charAt(0));
	if (check_char == 1)
		decimal = true;
	else if (check_char < 1)
		return false;
	 
	for (var i = 1; i < object_value.length; i++)	{
		check_char = number_format.indexOf(object_value.charAt(i))
		if (check_char < 0) {
			return false;
		} else if (check_char == 1)	{
			if (decimal)
				return false;
			else
				decimal = true;
		} else if (check_char == 0) {
			if (decimal || digits)	
			trailing_blank = true;
		}	else if (trailing_blank) { 
			return false;
		} else {
			digits = true;
		}
	}	
	
	return true;
}

function EW_checkrange(object_value, min_value, max_value) {
	if (object_value.length == 0)
		return true;
	
	if (!EW_checknumber(object_value))
		return false;
	else
		return (EW_numberrange((eval(object_value)), min_value, max_value));	
	
	return true;
}

function EW_checktime(object_value) {
	if (object_value.length == 0)
		return true;
	
	isplit = object_value.indexOf(':');
	
	if (isplit == -1 || isplit == object_value.length)
		return false;
	
	sHour = object_value.substring(0, isplit);
	iminute = object_value.indexOf(':', isplit + 1);
	
	if (iminute == -1 || iminute == object_value.length)
		sMin = object_value.substring((sHour.length + 1));
	else
		sMin = object_value.substring((sHour.length + 1), iminute);
	
	if (!EW_checkinteger(sHour))
		return false;
	else if (!EW_checkrange(sHour, 0, 23)) 
		return false;
	
	if (!EW_checkinteger(sMin))
		return false;
	else if (!EW_checkrange(sMin, 0, 59))
		return false;
	
	if (iminute != -1) {
		sSec = object_value.substring(iminute + 1);		
		if (!EW_checkinteger(sSec))
			return false;
		else if (!EW_checkrange(sSec, 0, 59))
			return false;	
	}
	
	return true;
}

function EW_checkphone(object_value) {
	if (object_value.length == 0)
		return true;
	
	if (object_value.length != 12)
		return false;
	
	if (!EW_checknumber(object_value.substring(0,3)))
		return false;
	else if (!EW_numberrange((eval(object_value.substring(0,3))), 100, 1000))
		return false;
	
	if (object_value.charAt(3) != "-" && object_value.charAt(3) != " ")
		return false
	
	if (!EW_checknumber(object_value.substring(4,7)))
		return false;
	else if (!EW_numberrange((eval(object_value.substring(4,7))), 100, 1000))
		return false;
	
	if (object_value.charAt(7) != "-" && object_value.charAt(7) != " ")
		return false;
	
	if (object_value.charAt(8) == "-" || object_value.charAt(8) == "+")
		return false;
	else
		return (EW_checkinteger(object_value.substring(8,12)));
}


function EW_checkzip(object_value) {
	if (object_value.length == 0)
		return true;
	
	if (object_value.length != 5 && object_value.length != 10)
		return false;
	
	if (object_value.charAt(0) == "-" || object_value.charAt(0) == "+")
		return false;
	
	if (!EW_checkinteger(object_value.substring(0,5)))
		return false;
	
	if (object_value.length == 5)
		return true;
	
	if (object_value.charAt(5) != "-" && object_value.charAt(5) != " ")
		return false;
	
	if (object_value.charAt(6) == "-" || object_value.charAt(6) == "+")
		return false;
	
	return (EW_checkinteger(object_value.substring(6,10)));
}


function EW_checkcreditcard(object_value) {
	var white_space = " -";
	var creditcard_string = "";
	var check_char;
	
	if (object_value.length == 0)
		return true;
	
	for (var i = 0; i < object_value.length; i++) {
		check_char = white_space.indexOf(object_value.charAt(i));
		if (check_char < 0)
			creditcard_string += object_value.substring(i, (i + 1));
	}	
	
	if (creditcard_string.length == 0)
		return false;	 
	
	if (creditcard_string.charAt(0) == "+")
		return false;
	
	if (!EW_checkinteger(creditcard_string))
		return false;
	
	var doubledigit = creditcard_string.length % 2 == 1 ? false : true;
	var checkdigit = 0;
	var tempdigit;
	
	for (var i = 0; i < creditcard_string.length; i++) {
		tempdigit = eval(creditcard_string.charAt(i));		
		if (doubledigit) {
			tempdigit *= 2;
			checkdigit += (tempdigit % 10);			
			if ((tempdigit / 10) >= 1.0)
				checkdigit++;			
			doubledigit = false;
		}	else {
			checkdigit += tempdigit;
			doubledigit = true;
		}
	}
		
	return (checkdigit % 10) == 0 ? true : false;
}


function EW_checkssc(object_value) {
	var white_space = " -+.";
	var ssc_string="";
	var check_char;
	
	if (object_value.length == 0)
		return true;
	
	if (object_value.length != 11)
		return false;
	
	if (object_value.charAt(3) != "-" && object_value.charAt(3) != " ")
		return false;
	
	if (object_value.charAt(6) != "-" && object_value.charAt(6) != " ")
		return false;
	
	for (var i = 0; i < object_value.length; i++) {
		check_char = white_space.indexOf(object_value.charAt(i));
		if (check_char < 0)
			ssc_string += object_value.substring(i, (i + 1));
	}	
	
	if (ssc_string.length != 9)
		return false;	 
	
	if (!EW_checkinteger(ssc_string))
		return false;
	
	return true;
}
	

function EW_checkemail(object_value) {
	if (object_value.length == 0)
		return true;
	
	if (!(object_value.indexOf("@") > -1 && object_value.indexOf(".") > -1))
		return false;    
	
	return true;
}
	
// GUID {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}	
function EW_checkGUID(object_value)	{
	if (object_value.length == 0)
		return true;
	if (object_value.length != 38)
		return false;
	if (object_value.charAt(0)!="{")
		return false;
	if (object_value.charAt(37)!="}")
		return false;	
	
	var hex_format = "0123456789abcdefABCDEF";
	var check_char;	
	
	for (var i = 1; i < 37; i++) {		
		if ((i==9) || (i==14) || (i==19) || (i==24)) {
			if (object_value.charAt(i)!="-")
				return false;
		} else {
			check_char = hex_format.indexOf(object_value.charAt(i));
			if (check_char < 0)
				return false;
		}
	}
	return true;
}
	

// Update a combobox with filter value
// object_value_array format
// object_value_array[n] = option value
// object_value_array[n+1] = option text 1
// object_value_array[n+2] = option text 2
// object_value_array[n+3] = option filter value
function EW_updatecombo(obj, object_value_array, filter_value) {
	var value = obj.options[obj.selectedIndex].value;
	for (var i = obj.length-1; i > 0; i--) {
		obj.options[i] = null;
	}	
	for (var j=0; j<object_value_array.length; j=j+4) {
		if (object_value_array[j+3].toUpperCase() == filter_value.toUpperCase()) {
			EW_newopt(obj, object_value_array[j], object_value_array[j+1], object_value_array[j+2]);			
		}	
	}
	EW_selectopt(obj, value);
}

// Create combobox option 
function EW_newopt(obj, value, text1, text2) {
	var text = text1;
	if (text2 != "")
		text += ", " + text2;
	var optionName = new Option(text, value, false, false)
	var length = obj.length;
	obj.options[length] = optionName;
}

// Select combobox option
function EW_selectopt(obj, value) {
	for (var i = obj.length-1; i>=0; i--) {
		if (obj.options[i].value.toUpperCase() == value.toUpperCase()) {
			obj.selectedIndex = i;
			break;
		}
	}
}

// Get image width/height
function EW_getimagesize(file_object, width_object, height_object) {
	if (navigator.appVersion.indexOf("MSIE") != -1)	{
		myimage = new Image();
		myimage.onload = function () {
			width_object.value = myimage.width; height_object.value = myimage.height;
		}		
		myimage.src = file_object.value;
	}
}