package org.infinite.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.w3c.dom.Document;

public class XmlUtil {

	public static final String XMLPATH = "xml/";
	private static final String XSLPATH = "xsl/";


	/**
	 * Transform the Document object to a plain text XML 
	 * @param doc xml Document
	 * @return xml string
	 * @throws Exception
	 */
	public static String xml2String(Document doc) throws Exception{

		ByteArrayOutputStream ba = new ByteArrayOutputStream();
		TransformerFactory tf = TransformerFactory.newInstance(); 
		Transformer tr;

		try {
			tr = tf.newTransformer();

			tr.setOutputProperty( OutputKeys.METHOD,"xml");
			tr.setOutputProperty("encoding", System.getProperty("file.encoding") );
			DOMSource src = new DOMSource(doc);

			StreamResult res = new StreamResult(ba);

			tr.transform(src,res);

			ba.close();
			ba.flush();
		} catch (TransformerException e) {
			throw new Exception("TransformerException : "+e.toString() );
		} catch (IOException e) {
			throw new Exception("IOException : "+e.toString() );
		}

		return new String(ba.toByteArray());

	}


	/**
	 * Transform the document xml applying the XSLT using the given file. 
	 * @param szXML xml Document as a plain text string
	 * @param szXSLname the XSL filename (without extension nor path)
	 * @return XSLT output (mimetype taken from XSL parameters)
	 * @throws Exception
	 */
	public static String xml2String(String szXML,String szXSLname) throws Exception{	
		Source src = new StreamSource(new ByteArrayInputStream(szXML.getBytes()));
		return xml2String(src, szXSLname);	
	}


	/**
	 * Transform the document xml applying the XSLT using the given file. 
	 * @param szXML xml Document
	 * @param szXSLname the XSL filename (without extension nor path)
	 * @return XSLT output (mimetype taken from XSL parameters)
	 * @throws Exception
	 */
	public static String xml2String(Document doc,String szXSLname) throws Exception{	
		DOMSource src = new DOMSource(doc);
		return xml2String(src, szXSLname);	
	}


	/**
	 * Transform the document xml applying the XSLT using the given file. 
	 * @param szXML xml Document as javax.xml.transform.Source object
	 * @param szXSLname the XSL filename (without extension nor path)
	 * @return XSLT output (mimetype taken from XSL parameters)
	 * @throws Exception
	 */
	public static String xml2String(Source src,String szXSLname) throws Exception{

		ByteArrayOutputStream ba = new ByteArrayOutputStream();
		TransformerFactory tf = TransformerFactory.newInstance(); 
		Transformer tr;
		try {

			if(szXSLname==null || szXSLname.length()==0){		
				tr = tf.newTransformer();
				tr.setOutputProperty( OutputKeys.METHOD,"xml");
			}
			else{		
				InputStream is= null;
				try {
					is=XmlUtil.class.getClassLoader().getResourceAsStream(XSLPATH+szXSLname+".xsl");
				} catch (Exception e) {
					e.printStackTrace();
				}	
				
				StreamSource s = new StreamSource(is);
				tr = tf.newTransformer(s);
				tr.setOutputProperty( OutputKeys.METHOD,"html");
			}

			tr.setOutputProperty("encoding", System.getProperty("file.encoding") );

			StreamResult res = new StreamResult(ba);
			tr.transform(src,res);
			ba.close();
			ba.flush();
		} 
		catch (TransformerException e) {
			throw new Exception("TransformerException : "+e.toString() );
		}
		catch (IOException e) {
			throw new Exception("IOException : "+e.toString() );
		}


		return new String(ba.toByteArray());

	}

	
	public static Document name2Doc(String szName){
		try {
			InputStream is= null;
			try {
				is=XmlUtil.class.getClassLoader().getResourceAsStream(szName);
			} catch (Exception e) {
				e.printStackTrace();
			}
						
			return DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(is );
		} catch (Exception e){
			GenericUtil.err(szName,e);
			return null;
		}

	}
	
}
