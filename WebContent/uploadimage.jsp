<%@ page contentType="text/html;charset=gb2312" language="java"
	import="java.io.*,java.awt.Image,java.awt.image.*,com.sun.image.codec.jpeg.*,java.sql.*,jspSmart.*,java.util.*"%>
<%@ page
	import="java.awt.image.*, javax.imageio.*, java.io.*, java.awt.*"%>
<%
SmartUpload mySmartUpload =new SmartUpload();
long file_size_max=10000000;
String fileName2="",ext="",testvar="";
String url="uploadfile\\images\\";      //Ӧ��֤�ڸ�Ŀ¼���д�Ŀ¼�Ĵ���
String newurl=null;
String saveurl=null;
String filename=null;
//��ʼ��
mySmartUpload.initialize(pageContext);
//ֻ�������ش����ļ�
try {
 mySmartUpload.setAllowedFilesList("jpg,gif");
//�����ļ� 
 mySmartUpload.upload();
} catch (Exception e){
%>
<script>
  alert("ֻ�����ϴ�.jpg��.gif����ͼƬ�ļ�");
  window.location='upload.htm';
  </script>
<%
}
try{
    for(jspSmart.File myFile: mySmartUpload.getFiles().getCollection())
    {
    if (myFile.isMissing()){%>
<script>
   alert("����ѡ��Ҫ�ϴ����ļ�");
   window.location='upload.jsp';
   </script>
<%
	}
    else{
      //String myFileName=myFile.getFileName(); //ȡ�����ص��ļ����ļ���
   ext= myFile.getFileExt(); //ȡ�ú�׺��
			int file_size = myFile.getSize(); //ȡ���ļ��Ĵ�С  
			saveurl = "";
			if (file_size < file_size_max) {
				//�����ļ�����ȡ�õ�ǰ�ϴ�ʱ��ĺ�����ֵ
				Calendar calendar = Calendar.getInstance();
				filename = String.valueOf(calendar.getTimeInMillis());
				saveurl = request.getSession().getServletContext().getRealPath("/") + url;
				saveurl += filename + "." + ext; //����·��
				myFile.saveAs(saveurl, SmartUpload.SAVE_PHYSICAL);
				//out.print(filename);
				//-----------------------�ϴ���ɣ���ʼ��������ͼ-------------------------    
				java.io.File file = new java.io.File(saveurl); //����ղ��ϴ����ļ�
				newurl = request.getSession().getServletContext().getRealPath("/") + url + filename
						+ "_min." + ext; //�µ�����ͼ�����ַ
				Image src = javax.imageio.ImageIO.read(file); //����Image����
				float tagsize = 200;
				int old_w = src.getWidth(null); //�õ�Դͼ��
				int old_h = src.getHeight(null);
				int new_w = 0;
				int new_h = 0; //�õ�Դͼ��
				int tempsize;
				float tempdouble;
				if (old_w > old_h) {
					tempdouble = old_w / tagsize;
				} else {
					tempdouble = old_h / tagsize;
				}
				new_w = Math.round(old_w / tempdouble);
				new_h = Math.round(old_h / tempdouble);//������ͼ����
				BufferedImage tag = new BufferedImage(new_w, new_h, BufferedImage.TYPE_INT_RGB);
				tag.getGraphics().drawImage(src, 0, 0, new_w, new_h, null); //������С���ͼ
				FileOutputStream newimage = new FileOutputStream(newurl); //������ļ���
				JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(newimage);
				encoder.encode(tag); //��JPEG����
				newimage.close();

				//ImageIO.write(tag, "jpg", response.getOutputStream());

			} else {
				out.print("<script");
				out.print("alert('�ϴ��ļ���С���ܳ���" + (file_size_max / 1000) + "K');");
				out.print("window.location='upload.jsp;'");
				out.print("</script>");
			}
		}
    }
	} catch (Exception e) {
		e.toString();
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
�ϴ��ɹ����ļ���"<%=filename%>"
<p><a href="upload.jsp"> ����һ����</a></p>

</body>
</html>