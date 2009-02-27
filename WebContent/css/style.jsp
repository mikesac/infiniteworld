<style>
BODY {
	background-image: url("<%=request.getContextPath()%>/imgs/web/bg2.gif");
	
}
BODY table td tr{
font-family: Verdana,Arial;
	font-size: 9pt;
	font-weight: bold;
	color:#684331;
}

.error{color:#CF001C; }

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

.firstParty {
	background-image:
		url("<%=request.getContextPath()%>/imgs/web/silver.jpg");
	font-size: 10pt;
}

.secondParty {
	background-image: url("<%=request.getContextPath()%>/imgs/web/gold.jpg")
		;
	font-size: 10pt;
}

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

.thp {width: 100px;height: 10px;background-color: black;z-index: 1}
.hpt {color: white;font-size: 6pt;z-index: 30;position: absolute;}
.chp {height: 10px;background-color: #EF1D1D;color: white;font-size: 6pt;position: absolute;z-index: 2}

.tmp {
	width: 100px;
	height: 10px;
	background-color: black;
	z-index: 1
}

.mpt {
	color: white;
	font-size: 6pt;
	z-index: 30;
	position: absolute;
}

.cmp {
	height: 10px;
	background-color: #1B1DDF;
	color: black;
	font-size: 6pt;
	position: absolute;
	z-index: 2
}

.tap {
	width: 100px;
	height: 10px;
	background-color: black;
	z-index: 1
}

.apt {
	color: white;
	font-size: 6pt;
	z-index: 30;
	position: absolute;
}

.cap {
	height: 10px;
	background-color: #EFC20E;
	color: black;
	font-size: 6pt;
	position: absolute;
	z-index: 2
}

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

.shield {
	background-image:
		url('<%=request.getContextPath()%>/imgs/item/shield.png');
	background-repeat: no-repeat;
	width: 50px;
	color: black;
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



#side-nw{width:19px;height:19px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-nw.png');background-repeat:no-repeat;}
#side-n{height:19px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-n.png');background-repeat:repeat-x;}
#side-ne{width:19px;height:19px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-ne.png');background-repeat:no-repeat;}
#side-sw{width:19px;height:19px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-sw.png');background-repeat:no-repeat;}
#side-s{height:19px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-s.png');background-repeat:repeat-x;}
#side-se{width:19px;height:19px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-se.png');background-repeat:no-repeat;}
#side-e{width:19px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-e.png');background-repeat:repeat-y;}
#side-w{width:19px;background-image:url('<%=request.getContextPath()%>/imgs/tw/bg-w.png');background-repeat:repeat-y;}
#side {background-image:url('<%=request.getContextPath()%>/imgs/web/bg.jpg');background-repeat:repeat;}

.char{
	background-image:url('<%=request.getContextPath()%>/imgs/web/bg.jpg');background-repeat:repeat;
	-moz-border-radius: 10px 10px 10px 10px;
	border:2px solid #664532;
	margin: 1% 1% 1% 1%;

}


.thp_big{width: 100px;height: 15px;background-color: black;z-index: 1; border:3px outset gray;}
.hpt_big{color: white;font-size: 6pt;z-index: 30;position: absolute;}
.chp_big{height: 15px;background-color: #EF1D1D;color: white;font-size: 8pt;position: absolute;z-index: 2;}

.tmp_big{width: 100px;height: 15px;background-color: black;z-index: 1;  border:3px outset gray;}
.mpt_big{color: white;font-size: 6pt;z-index: 30;position: absolute;}
.cmp_big{height: 15px;background-color: #1B1DDF;color: white;font-size: 8pt;position: absolute;z-index: 2;}

.tap_big{width: 100px;height: 15px;background-color: black;z-index: 1;  border:3px outset gray;}
.apt_big{color: white;font-size: 6pt;z-index: 30;position: absolute;}
.cap_big{height: 15px;background-color: #EFC20E;color: white;font-size: 8pt;position: absolute;z-index: 2;}

.tcp_big{width: 100px;height: 15px;background-color: black;z-index: 1;  border:3px outset gray;}
.cpt_big{color: white;font-size: 6pt;z-index: 30;position: absolute;}
.ccp_big{height: 15px;background-color: #9800F0;color: white;font-size: 8pt;position: absolute;z-index: 2;}

.avatar{margin:10px 10px 10px 10px;width: 100px;height: 100px;}

</style>