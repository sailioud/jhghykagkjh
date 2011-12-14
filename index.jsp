<%-- 
    Document   : index
    Created on : 10 Δεκ 2011, 8:09:39 μμ
    Author     : alexiaKourfali
--%>


<%--http://www.java-tips.org/java-se-tips/javax.xml.parsers/how-to-read-xml-file-in-java.html--%>
 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%--imports--%>
<%@page language="java" %> 
<%@page import="java.util.*"%> 
<%@page import="java.io.File"%>
<%@page import="java.lang.String.*"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="org.w3c.dom.NodeList"%>

<%--declarations--%>
<%String FirstQuantity =request.getParameter("txtFirstQ");%>
<%String SecondQuantity =request.getParameter("txtSecondQ");%>
<%String ThirdQuantity =request.getParameter("txtThirdQ");%>

<%if(FirstQuantity==null){FirstQuantity="0";}%>
<%if(SecondQuantity==null){SecondQuantity="0";}%>
<%if(ThirdQuantity==null){ThirdQuantity="0";}%>


<%--*****************************************************************************
 *                                                                              *
 *                   function to calculate total expenses                       *
 *                                                                              *
 *****************************************************************************--%>
<script language="javascript">
function calculateAll()
{

    FirstPrice = document.All.txtFirstP.value
    SecondPrice = document.All.txtSecondP.value;
    ThirdPrice = document.All.txtThirdP.value;
    
    FirstQuantity = document.All.txtFirstQ.value
    SecondQuantity = document.All.txtSecondQ.value;
    ThirdQuantity = document.All.txtThirdQ.value;    

    FirstPrice = Number(FirstPrice)
    SecondPrice = Number(SecondPrice)
    ThirdPrice = Number(ThirdPrice)
    FirstQuantity = Number(FirstQuantity)
    SecondQuantity = Number(SecondQuantity)
    ThirdQuantity = Number(ThirdQuantity)    


    Sum1 = (FirstPrice*FirstQuantity)
    Sum2 = (SecondPrice*SecondQuantity)
    Sum3 = (ThirdPrice*ThirdQuantity)
    
    document.All.txtSum1.value = Sum1
    document.All.txtSum2.value = Sum2
    document.All.txtSum3.value = Sum3
    
    All = (Sum1+Sum2+Sum3)

    document.All.txtTotal.value = All
}


</script>

<%--*****************************************************************************
 *                                                                              *
 *                     xml parser for the my_list file                          *
 *                                                                              *
 *****************************************************************************--%>

<%
    String prices = application.getRealPath("/" + request.getParameter("my_list.xml"));
    prices=prices.substring(0,prices.length()-4);
    prices=prices+"my_list.xml";


    double[] my_list = new double[3];
  File fXmlFile = new File(prices);
  DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
  DocumentBuilder db = dbf.newDocumentBuilder();
  Document doc = db.parse(fXmlFile);
  doc.getDocumentElement().normalize();
  
  //System.out.println("Root element " + doc.getDocumentElement().getNodeName());
  NodeList nodeLst = doc.getElementsByTagName("Entry");

  for (int s = 0; s < nodeLst.getLength(); s++) 
  {

    Node fstNode = nodeLst.item(s);
    
    if (fstNode.getNodeType() == Node.ELEMENT_NODE) 
    {
          Element fstElmnt = (Element) fstNode;
          
          NodeList fstNmElmntLst = fstElmnt.getElementsByTagName("Price");
          Element fstNmElmnt = (Element)fstNmElmntLst.item(0);        
          NodeList fstNm = fstNmElmnt.getChildNodes();
          Node nV = (Node)fstNm.item(0);
          /*not sureeeee*/           
          my_list[s] = Double.parseDouble(nV.getNodeValue());

    }
  }
%>


<%--*****************************************************************************
 *                                                                              *
 *                       creation of the table                                  *
 *                                                                              *
 *****************************************************************************--%>
<html>
    <head> <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">   
        <title>Kourfali Alexia:  Project 3</title>
    </head>
    <body>  


<form method="post" action="index.jsp">
<table border="8">
    <tr>
      <th>Item</th>
      <th>Price</th>
      <th>Quantity</th>
      <th>Total</th>
    </tr>

    <tr>
      <td>Café</td>

          <td><%=my_list[0]%></td>
          <td><input type = "text" size="2" name="txtFirstQ" maxlength="3" class="textField" value="<%=FirstQuantity%>" onMouseOver="this.className = 'textFieldHover'" OnMouseOut="this.className = 'textField'"></td>
          <%
            if(FirstQuantity==null)
                {FirstQuantity="0";};
            int txtFirstQ = Integer.parseInt(FirstQuantity);
            %>        
          <td><%double Sum1=my_list[0]*txtFirstQ;%><%=Sum1%></td>
    </tr>

    <tr>
      <td>Azúcar</td>               
      <td><%=my_list[1]%></td>
          <td><input type = "text" size="2" name="txtSecondQ" maxlength="3" class="textField" value="<%=FirstQuantity%>" onMouseOver="this.className = 'textFieldHover'" OnMouseOut="this.className = 'textField'"></td>
          <%
            if(SecondQuantity==null)
                {SecondQuantity="0";};
            int txtSecondQ = Integer.parseInt(SecondQuantity);
          %>
      <td><%double Sum2=my_list[1]*txtSecondQ;%><%=Sum2%></td>
    </tr>

    <tr>
      <tr>
      <td>Agua</td>         
      <td><%=my_list[2]%></td>         
          <td><input type = "text" size="2" name="txtThirdQ" maxlength="3" class="textField" value="<%=FirstQuantity%>" onMouseOver="this.className = 'textFieldHover'" OnMouseOut="this.className = 'textField'"></td>
          <%
            if(ThirdQuantity==null)
                {ThirdQuantity="0";};
            int txtThirdQ = Integer.parseInt(ThirdQuantity);
          %>
      <td><%double Sum3=my_list[1]*txtThirdQ;%><%=Sum3%></td>
      </tr>


    <tr>
      <td>Total</td>  
          <td></td>
          <td></td>
          <td><%=Sum1+Sum2+Sum3+"€"%></td>
    </tr>
    

</table>
 
    <input type="submit" value="calculate Total cost" name="calculate Total cost" />   

    
<p><b>Enter Your Name: </b><input type="text" name="name"><br> 
<input type="submit" value="Submit">     
    
 <%--*****************************************************************************
 *   http://www.herongyang.com/jsp/cookie.html    http://www.techfaq360.com/viewTutorial.jsp?tutorialId=131             http://docs.oracle.com/javaee/1.3/api/javax/servlet/http/Cookie.html                                                              *
 *                              cookies http://www.roseindia.net/jsp/jspcookies.shtml                                        *
 *        http://blogs.oracle.com/CoreJavaTechTips/entry/cookie_handling_in_java_se                                                                      *
 *****************************************************************************--%>   
    
 <% 
String name1=request.getParameter("txtFirstQ"); 
//Set Cookie 
Date now1 = new Date(); 
String timestamp = now1.toString(); 
Cookie cookie1 = new Cookie ("txtFirstQ",name1); 
cookie1.setMaxAge(30 * 24 * 60 * 60); //Set Cookies for 30 days 
response.addCookie(cookie1); 

%>    
    
    <% 
String cookie_name1 = "txtFirstQ"; 
Cookie cookies1 [] = request.getCookies (); 
Cookie myCookie1 = null; 
if (cookies1 != null) 
{ 
for (int i = 0; i < cookies1.length; i++) 
{ 
if (cookies1 [i].getName().equals (cookie_name1)) 
// we have added the cookie with name "name" 
{ 
myCookie1 = cookies1[i]; 
break; 
} 
} 
} 
%> 


 <% 
String name2=request.getParameter("txtSecondQ"); 
//Set Cookie 
Date now2 = new Date(); 
String timestamp2 = now2.toString(); 
Cookie cookie2 = new Cookie ("txtSecondQ",name1); 
cookie2.setMaxAge(30 * 24 * 60 * 60); //Set Cookies for 30 days 
response.addCookie(cookie2); 

%>    
    
    <% 
String cookie_name2 = "txtSecondQ"; 
Cookie cookies2 [] = request.getCookies (); 
Cookie myCookie2 = null; 
if (cookies2 != null) 
{ 
for (int i = 0; i < cookies2.length; i++) 
{ 
if (cookies2 [i].getName().equals (cookie_name2)) 
// we have added the cookie with name "name" 
{ 
myCookie2 = cookies2[i]; 
break; 
} 
} 
} 
%> 

 <% 
String name3=request.getParameter("txtThirdQ"); 
//Set Cookie 
Date now3 = new Date(); 
String timestamp3 = now3.toString(); 
Cookie cookie3 = new Cookie ("txtThirdQ",name1); 
cookie3.setMaxAge(30 * 24 * 60 * 60); //Set Cookies for 30 days 
response.addCookie(cookie3); 

%>    
    
<% 
String cookie_name3 = "txtThirdQ"; 
Cookie cookies3 [] = request.getCookies (); 
Cookie myCookie3 = null; 
if (cookies3 != null) 
{ 
for (int i = 0; i < cookies3.length; i++) 
{ 
if (cookies3 [i].getName().equals (cookie_name3)) 
// we have added the cookie with name "name" 
{ 
myCookie3 = cookies3[i]; 
break; 
} 
} 
} 
%> 

 


<% 
if (myCookie1 == null) { 
%> 
No Cookie found with the name <%=cookie_name1%> 
<% 
} else { 
%> 
<p>Cookie Value1: <%=myCookie1.getValue()%>. 
<% 
} 
%> 



<% 
if (myCookie2 == null) { 
%> 
No Cookie found with the name <%=cookie_name2%> 
<% 
} else { 
%> 
<p>Cookie Value2: <%=myCookie2.getValue()%>. 
<% 
} 
%> 


<%
if (myCookie3 == null) { 
%> 
No Cookie found with the name <%=cookie_name3%> 
<% 
} else { 
%> 
<p>Cookie Value3: <%=myCookie3.getValue()%>. 
<% 
} 
%> 


<%--*****************************************************************************
 *                                                                              *
 *                              extra buttons                                   *
 *                                                                              *
 *****************************************************************************--%>

<a href="http://dl.dropbox.com/u/16170471/report_kourfali.pdf" target="_blank">?</a>
<a href="http://dl.dropbox.com/u/15863529/cartScript.zip" target="_blank">!1</a>
<a href="http://dl.dropbox.com/u/15863529/cartBeans.zip" target="_blank">!2</a>



</form>
      





</body> 
</html> 