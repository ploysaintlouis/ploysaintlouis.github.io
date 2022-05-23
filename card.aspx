﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="card.aspx.cs" Inherits="tnamecard.card" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Digital Name Card</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript" charset="UTF-8" src="https://code.jsqr.de/jsqr-1.0.2-min.js"></script>
  <script type="text/javascript" src="vcard.js"></script>

  <style>
canvas {
  background-color: #FFF;
}
@font-face {
  font-family: 'PSL';
  src: url('./PSL001pro.ttf') format('truetype');
    font-weight: 400;
}


@font-face {
  font-family: 'PSL';
  src: url('./PSL002pro.ttf') format('truetype');
  font-weight: 700;
}


@font-face {
  font-family: 'PSL';
  src: url('./PSL162Pro.otf') format("opentype");
  font-weight: 600;
}


@font-face {
  font-family: 'PSLKandaModernPro';
  src: url('./PSL160Pro.otf') format("opentype");
  font-weight: bold;
}


@font-face {
  font-family: 'PSLKandaModernPro';
  src: url('./PSL158Pro.otf') format("opentype");
  font-weight: normal;
}

body {
   background-color: #F27024;
   /*font-family: 'PSL PSLKandaModernPro' !important;*/
}

button.accordion {
    background-color: #FFFFFF;
    color: white;
    cursor: pointer;
    padding: 10px;
    width: 90%;
    border: none;
    text-align: left;
    outline: none;
    font-size: 15px;
}

button.accordion.active, button.accordion:hover {
    background-color: #FFFFFF;
}

button.accordion:after {
    content: '\002B';
    color: #F36E20;
    font-weight: bold;
    float: right;
    margin-left: 5px;
}

button.accordion.active:after {
    content: "\2212";
}

div.panel {
    padding: 0 10px;
    width: 90%;
    background-color: #FFFFFF;
    max-height: 0;
    overflow: hidden;
    transition: max-height 0.2s ease-out;
}

  .center{
  position:fixed;
  bottom:20px;
  left:10%;
  width:60%;
}

 .center .btn{
   background:#F36E20;
   width:100%;
   color:white;
   font-weight:bold;
   border-radius: 64px;
     padding:10px;
  }

  font {
    line-height: 1.2em;
  }
  </style>

</head>
<body>
    <form id="form1" runat="server">
        <%if (Request.Params["emp"] != null & false) { %>
<div class="center">
    <asp:Button runat="server" id="btnSave" class="btn" Text="Save Card" OnClick="Button1_Click" />
</div>
        <% } %>
<!-- <div class="row" style="margin-left:0px;margin-right:0px;background-color:#F27024;height:100%;"> -->
<div class="row" style="margin-left:0px;margin-right:0px;background-color:#6f5f5e;height:100%;">
<div class="col" style="margin-left:15px;text-align:center;">
    <asp:HiddenField ID="carddata" runat="server" />
<!--<br><img src="logoN.png" alt="Image" height="150"> -->
<br><img src="kss.png" alt="Image" height="80">
<!--     <br><br>
<font color="#FFFFFF" size="6" face="PSL"><b>หลักทรัพย์ธนชาต</b><br></font>
<font color="#FFFFFF" size="5" face="PSL"><b>Thanachart Securities</b><br></font> -->
     <%if (Request.Params["emp"] != null) { %>
    <br>
    <font color="#FFFFFF" size="5" face="PSL"><asp:Label ID="Lab_Tname" runat="server" Text="Label"></asp:Label></font>
    <br />
    <font color="#FFFFFF" size="5" face="PSL"><asp:Label ID="Lab_Ename" runat="server" Text="Label"></asp:Label></font>
    <br><br>
    <font color="#FFFFFF" size="5" face="PSL"><asp:Label ID="Lab_Position" runat="server" Text="Label"></asp:Label></font>
    <br />
    <font color="#FFFFFF" size="5" face="PSL"><asp:Label ID="Lab_Department" runat="server" Text="Label"></asp:Label></font>
    <br />
    <font color="#FFFFFF" size="5" face="PSL"><asp:Label ID="Lab_Tel" runat="server" Text="Label"></asp:Label></font>
    <br />
    <font color="#FFFFFF" size="4" face="PSL"><asp:Label ID="Lab_Email" runat="server" Text="Label"></asp:Label></font>

    <br><br><asp:PlaceHolder ID="plBarCode" runat="server" /><div id="preview"></div><br><br>
     <% } %>
<font color="#FFFFFF" size="5" face="PSL">Head Office 0x xxx xxxx<br></font>
<font color="#FFFFFF" size="5" face="PSL">www.ployploy.com<br></font>
<font color="#FFFFFF" size="5" face="PSL">LINE: @ployploy<br></font>
<font color="#FFFFFF" size="5" face="PSL">Facebook: PloyPloy Securities<br></font>
<br><br><br><br><br>
</div>
<a style="display:none" id="vcard">vcard</a>
</div>
    </form>
</body>
</html>
<script>
  $(document).ready(function(){
    var isMobile = false; //initiate as false
// device detection
    if( /Android|webOS|iPhone|iPad|iPod|Opera Mini/i.test(navigator.userAgent) ) {
      isMobile = true;
      const dataFromWeb = document.getElementById('carddata').value;
      let dataInputOject = {};

      dataFromWeb.split("$").map(function(val) {
      if (val) {
          let splitData = val.split(":");
          dataInputOject[splitData[0].replace('\n', '')] = splitData[1];
      }
      });

      const qr = new JSQR();

      let code = new qr.Code();
      let telNumber = dataInputOject['TEL'].split('|');
      let telOne = (telNumber[0] !== 'undefined') ? telNumber[0] : '';
      let telTwo = (telNumber[1] !== 'undefined') ? telNumber[1] : '';
      code.encodeMode = code.ENCODE_MODE.UTF8_SIGNATURE;
      code.version = code.DEFAULT;
      code.errorCorrection = code.ERROR_CORRECTION.H;
      let input = new qr.Input();
      input.dataType = input.DATA_TYPE.MECARD;
      input.data = {
        "firstName": dataInputOject.N,
        "lastName": dataInputOject.LN,
        "eMail": dataInputOject.EMAIL,
        "phoneNumber": telOne,
        "poBox": "",
        "room": "",
        "street": "",
        "city": "",
        "state": "",
        "zip": "",
        "country": "",
        "videoCall": "",
        "url": "",
        "birthday": null,
        "memo": "Title: " + dataInputOject['ORG']
      };

      let matrix = new qr.Matrix(input, code);
      matrix.scale = 3;

      const canvas = document.createElement('canvas');
      canvas.setAttribute('width', matrix.pixelWidth);
      canvas.setAttribute('height', matrix.pixelWidth);
      canvas.getContext('2d').fillStyle = 'rgb(0,0,0)';
      matrix.draw(canvas, 0, 0);
      document.getElementById('preview').appendChild(canvas);

      var vcardOne = '';
      var vcardEnd = '';
      var vcard = 'BEGIN:VCARD\r\n' +
                  'VERSION:2.1\r\n' +
                  'N:' + dataInputOject.LN + ";" + dataInputOject.N + '\r\n' +
                  'EMAIL;type=INTERNET;type=WORK:' + dataInputOject.EMAIL +'\r\n' +
                  'TEL;WORK;VOICE:' + telOne + '\r\n';


      if (telTwo !== undefined) {
        vcardOne = 'TEL;WORK;VOICE:' + telTwo + '\r\n';
      }
      vcardEnd = 'END:VCARD';
      var res = vcard.concat(vcardOne, vcardEnd);
      console.log(vcard, vcardOne, vcardEnd, res)

      document.getElementById('vcard').href = "data:text/x-vcard;charset=utf-8," + encodeURIComponent( res );
      document.getElementById("vcard").click();
    }
  });
</script>