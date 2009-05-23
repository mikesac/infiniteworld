
BODY {
	/*background-image: url("<%=request.getContextPath()%>/imgs/web/bg3.jpg");*/
	background-color:black;
	
}
BODY table td tr{
font-family: Verdana,Arial;
	font-size: 9pt;
	font-weight: bold;
	color:#684331;
}

.error{color:#CF001C;font-size:9pt;font-weight:bold; }

.fight {
	width: 90%;
}

.lgnd {
	background-image:
		url("<%=request.getContextPath()%>/imgs/web/hdrScrl.gif");
	background-repeat: no-repeat;
	width: 140px;
	height: 35;
	font-size: 10pt;
	font-weight: bold;
	padding-top: 5px;
}

.round {
	border: 3px double brown;
	background-image: url("<%=request.getContextPath()%>/imgs/web/bg2.gif");
	margin-bottom: 1%;
}


.firstSide{color:green;}
.secondSide{color:red;}

.party {
	width: 90%;
}

.party1 {
	border: 1px outset gray;
}

.party2 {
	border: 1px outset gray;
}

.monster {
	font-size: 5pt;
}

.points {
	background-image: none;
	background-color: transparent;
	font-size: 6pt;
}

.thp {width: 100px;height: 10px;background-color: black;z-index: 1;position:relative;}
.hpt {color: white;font-size: 6pt;z-index: 30;position: absolute;white-space:nowrap;top:0px;}
.chp {height: 10px;background-image: url(<%=request.getContextPath()%>/imgs/web/flame.gif);color: white;font-size: 6pt;position: relative;z-index: 2;}


.tmp {width: 100px;height: 10px;background-color: black;z-index: 1;position:relative;}
.mpt {color: white;font-size: 6pt;z-index: 30;position: absolute;white-space:nowrap;top:0px;}
.cmp {height: 10px;background-color: #1B1DDF;color: black;font-size: 6pt;position: relative;z-index: 2}

.tap {width: 100px;height: 10px;background-color: black;z-index: 1;position:relative;}
.apt {color: white;font-size: 6pt;z-index: 30;position: absolute;white-space:nowrap;top:0px;}
.cap {height: 10px;background-color: #EFC20E;color: black;font-size: 6pt;position: relative;z-index: 2}

.d20r {
	background-image:
		url('<%=request.getContextPath()%>/imgs/dices/d20empty_r.png');
	background-repeat: no-repeat;
	width: 50px;
	color: black;
	font-size: 8pt;
	font-weight: bold;
	padding-top: 14px;
	padding-left: 16px;
}

.d20b {
	background-image:
		url('<%=request.getContextPath()%>/imgs/dices/d20empty_b.png');
	background-repeat: no-repeat;
	width: 50px;
	color: white;
	font-size: 8pt;
	font-weight: bold;
	padding-top: 14px;
	padding-left: 16px;
}


.rewards {
	font-size: 6pt;
}

.hit {
	color: #AF0000;
	text-align: center;
	font-size: 8pt;
	font-weight: bold;
}

.miss {
	color: #008F13;
	text-align: center;
	font-size: 8pt;
	font-weight: bold;
}

.rest {
	color: #EFC20E;
	text-align: center;
	font-size: 8pt;
	font-weight: bold;
}

.monster {
	border: 3px double brown;
	width: 650px;
	background-image:
		url("<%=request.getContextPath()%>/imgs/web/silver.jpg");
	font-size: 10pt;
}

.bigimg {
	border: 3px double black;
	margin: 1% 1% 1%;
}

.pediastats {
	border: 3px double brown;
	font-weight: bold;
	width: 200px;
	background-color: transparent;
	font-size: 10pt;
	background-image: url("<%=request.getContextPath()%>/imgs/web/bg2.gif");
	margin: 1% 1% 1%;
}

.pediadesc {
	border: 3px double brown;
	width: 200px;
	background-color: transparent;
	font-size: 8pt;
	background-image: url("<%=request.getContextPath()%>/imgs/web/bg2.gif");
	margin: 1% 1% 1%;
}



#side-nw{width:20px;height:15px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-nw.png');background-repeat:no-repeat;}
#side-n{height:15px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-n.png');background-repeat:repeat-x;}
#side-ne{width:20px;height:15px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-ne.png');background-repeat:no-repeat;}
#side-sw{width:20px;height:15px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-sw.png');background-repeat:no-repeat;}
#side-s{height:15px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-s.png');background-repeat:repeat-x;}
#side-se{width:20px;height:15px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-se.png');background-repeat:no-repeat;}
#side-e{width:20px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-e.png');background-repeat:repeat-y;}
#side-w{width:20px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-w.png');background-repeat:repeat-y;}
#side {background-color:#DDCDA5;}

#side2-nw{width:9px;height:9px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg2-nw.png');background-repeat:no-repeat;}
#side2-n{height:9px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg2-n.png');background-repeat:repeat-x;}
#side2-ne{width:9px;height:9px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg2-ne.png');background-repeat:no-repeat;}
#side2-sw{width:9px;height:9px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg2-sw.png');background-repeat:no-repeat;}
#side2-s{height:9px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg2-s.png');background-repeat:repeat-x;}
#side2-se{width:9px;height:9px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg2-se.png');background-repeat:no-repeat;}
#side2-e{width:9px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg2-e.png');background-repeat:repeat-y;}
#side2-w{width:9px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg2-w.png');background-repeat:repeat-y;}
#side2 {background-color:#e6d8b5;}

.char{
	background-image:url('<%=request.getContextPath()%>/imgs/web/bg.jpg');background-repeat:repeat;
	-moz-border-radius: 10px 10px 10px 10px;
	border:2px solid #664532;
	margin: 1% 1% 1% 1%;

}


.thp_big{width: 100px;height: 15px;background-color: black;z-index: 1; border:3px outset gray;}
.hpt_big{color: white;font-size: 6pt;z-index: 30;position: absolute;white-space:nowrap;}
.chp_big{height: 15px;background-image:url(<%=request.getContextPath()%>/imgs/web/blood.gif);color: white;font-size: 8pt;position: absolute;z-index: 2;}

.tmp_big{width: 100px;height: 15px;background-color: black;z-index: 1;  border:3px outset gray;}
.mpt_big{color: white;font-size: 6pt;z-index: 30;position: absolute;white-space:nowrap;}
.cmp_big{height: 15px;background-image:url(<%=request.getContextPath()%>/imgs/web/bubble.gif);color: white;font-size: 8pt;position: absolute;z-index: 2;}

.tap_big{width: 100px;height: 15px;background-color: black;z-index: 1;  border:3px outset gray;}
.apt_big{color: white;font-size: 6pt;z-index: 30;position: absolute;white-space:nowrap;}
.cap_big{height: 15px;background-image:url(<%=request.getContextPath()%>/imgs/web/flame.gif);color: white;font-size: 8pt;position: absolute;z-index: 2;}

.tcp_big{width: 100px;height: 15px;background-color: black;z-index: 1;  border:3px outset gray;}
.cpt_big{color: white;font-size: 6pt;z-index: 30;position: absolute;white-space:nowrap;}
.ccp_big{height: 15px;background-color: #9800F0;color: white;font-size: 8pt;position: absolute;z-index: 2;}

.txp_big{width: 200px;height: 30px;background-color: black;z-index: 1;  border:3px outset gray;}
.xpt_big{color: white;font-size: 6pt;z-index: 30;position: absolute;white-space:nowrap;}
.cxp_big{height: 30px;background-color: #07E4F6;color:#001B8F;font-size: 8pt;position: absolute;z-index: 2;}

.avatar{margin:5px 5px 5px 5px;width: 100px;height: 100px;border:5px double #61402D;}

.equipbody{width:500px;height:500px;background-image:url('<%=request.getContextPath()%>/imgs/web/equip_bg.png');background-repeat:no-repeat;}
.equipped{width:70px;height:70px;background-image: url("<%=request.getContextPath()%>/imgs/web/bg2.gif");border:3px inset gray;}

.smallfont{font-size: 7pt;}

.icon_med{
	background-image: url("<%=request.getContextPath()%>/imgs/web/icon_m.png");
	padding-top: 4px;padding-left:4px;
	width:44px;height:44px;
	background-repeat:no-repeat;
	}
	
#spellbook{
	width:700px;
	height:542px;
}

#triskel{
	width:228px; height:225px; 
	background-image: url(<%=request.getContextPath()%>/imgs/web/spell/triskel.png);
	background-repeat:no-repeat;
}

.bookpg1{
	border:0px;width:282px;height:443px; background-image: url("<%=request.getContextPath()%>/imgs/web/spell/bookbg.png");background-repeat:repeat-y;
	}
	
.bookpg2{
	border:0px;width:282px;height:443px;
	background-image: url("<%=request.getContextPath()%>/imgs/web/spell/bookbg2.png");
	background-repeat:repeat-y;
	}
	
#book_n{width:700px;height:28px;background-image: url("<%=request.getContextPath()%>/imgs/web/spell/book_n.png");background-repeat:no-repeat;}
#book_w{width:55px;height:443px;background-image: url("<%=request.getContextPath()%>/imgs/web/spell/book_w.png");background-repeat:no-repeat;}
#book_p1{width:282px;background-image: url("<%=request.getContextPath()%>/imgs/web/spell/bookbg.png");background-repeat:repeat-y;}
#book_c{width:27px;height:443px;background-image: url("<%=request.getContextPath()%>/imgs/web/spell/book_c.png");background-repeat:no-repeat;}
#book_p2{width:282px;background-image: url("<%=request.getContextPath()%>/imgs/web/spell/bookbg2.png");background-repeat:repeat-y;}
#book_e{width:55px;height:443px;background-image: url("<%=request.getContextPath()%>/imgs/web/spell/book_e.png");background-repeat:no-repeat;}
#book_s{width:700px;height:71px;background-image: url("<%=request.getContextPath()%>/imgs/web/spell/book_s.png");background-repeat:no-repeat;}

.buttonstyle{font-size: 7pt;width:50px;}

.up{width:30px;background-image: url("<%=request.getContextPath()%>/imgs/web/up.png");background-repeat:no-repeat;background-position: center;}
.down{width:30px;background-image: url("<%=request.getContextPath()%>/imgs/web/down.png");background-repeat:no-repeat;background-position: center;}
.rem{width:30px;background-image: url("<%=request.getContextPath()%>/imgs/web/remove.png");background-repeat:no-repeat;background-position: center;}
.nobut{width:30px;}

/* Applies to all unvisited links */
a:link {text-decoration:none;font-weight:bold;background-color:transparent;color:#684331;} 

/* Applies to all visited links */
a:visited {text-decoration:none;font-weight:bold;background-color: transparent;color:#684331;} 

/* Applies to links under the pointer */
a:hover{text-decoration:underline;font-weight:bold;background-color:transparent;color:#684331;} 

/* Applies to activated links */
a:active {text-decoration:underline;font-weight:bold;background-color:transparent;color:#684331;} 