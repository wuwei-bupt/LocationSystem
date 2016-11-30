var canvas,context,zoomIn,zoomOut,revert;
var img,//图片对象
    imgIsLoaded,//图片是否加载完成;
    imgX=0,
    imgY=0,
    imgScale=0.5;
	var layer1;
    var layer2;
    var ctx1;
    var ctx2;
      //var x = 2000;
      //var y = 1000;
      var WIDTH = 4381;
      var HEIGHT = 2228;
	  function init() {
	    layer1 = document.getElementById("layer1");
	    ctx1 = layer1.getContext("2d");
	    layer2 = document.getElementById("layer2");
	    ctx2 = layer2.getContext("2d");
		//画布在init里面重绘就好
		
	    setInterval(getXYandDraw, 1000);
	  }

	  function Ondraw() {
		drawImage();
		drawpoint(1000,500,"张三");
	  }

	  function drawbottom() {
		ctx1.clearRect(0, 0, WIDTH, HEIGHT);
		ctx1.drawImage(platform, 0, 0);
	  }

	  function drawpoint(x,y,name) { //draw point and word
			var real_x=imgX+Math.round(imgScale*x);
			var real_y=imgY+Math.round(imgScale*y);
			var radius=10*imgScale;
			ctx2.beginPath();
			ctx2.arc(real_x,real_y,radius,0,2*Math.PI);
			ctx2.fillStyle = "red";
			ctx2.fill();
			ctx2.stroke();
			var font_size = Math.round(imgScale*30);
			ctx2.font = 'bold '+font_size+'px arial';
	        	ctx2.fillStyle = 'blue';
			var xx=Number(real_x)-Number(30*imgScale);
			var yy=Number(real_y)-Number(10*imgScale);
	        	ctx2.fillText(name,xx,yy);
		  }

	 
(function int(){
    canvas=document.getElementById('canvas');
	zoomIn=document.getElementById('zoom-in');
	zoomOut=document.getElementById('zoom-out');
	revert=document.getElementById('revert');
    context=canvas.getContext('2d');
	 layer2 = document.getElementById("canvas");
	 ctx2 = layer2.getContext("2d");
    loadImg();
	   
		//画布在init里面重绘就好
		
	    setInterval(Ondraw, 100);
})();



function loadImg(){
    img=new Image();
    img.onload=function(){
        imgIsLoaded=true;
		imgScale=0.5;
        drawImage();
		
    }
    img.src="map.jpg";
}

function drawImage(){
    context.clearRect(0,0,canvas.width,canvas.height);
    context.drawImage(img,0,0,img.width,img.height,imgX,imgY,img.width*imgScale,img.height*imgScale);
	
}

zoomIn.onclick=function(event){
	var pos=windowToCanvas(canvas,event.clientX,event.clientY);
	imgScale*=1.3;
	imgX+=(img.width-1.3*img.width)/2;
	imgY+=(img.height-1.3*img.height)/2;
	drawImage();
}

zoomOut.onclick=function(event){
	var pos=windowToCanvas(canvas,event.clientX,event.clientY);
	imgScale*=0.8;
	if(imgScale>0.2){
		imgX+=(img.width-0.8*img.width)/2;
		imgY+=(img.height-0.8*img.height)/2;
		drawImage();
	}
	else{
		imgScale/=0.8;
	}
}

revert.onclick=function(event){
	imgX=0,
    imgY=0,
    imgScale=0.5;
	drawImage();
	
}
canvas.onmousedown=function(event){
    var pos=windowToCanvas(canvas,event.clientX,event.clientY);
    canvas.onmousemove=function(event){
        canvas.style.cursor="move";
        var pos1=windowToCanvas(canvas,event.clientX,event.clientY);
        var x=pos1.x-pos.x;
        var y=pos1.y-pos.y;
        pos=pos1;
        imgX+=x;
        imgY+=y;
        drawImage();
    }
    canvas.onmouseup=function(){
        canvas.onmousemove=null;
        canvas.onmouseup=null;
        canvas.style.cursor="default";
    }
}
canvas.onmousewheel=canvas.onwheel=function(event){
    var pos=windowToCanvas(canvas,event.clientX,event.clientY);
    event.wheelDelta=event.wheelDelta?event.wheelDelta:(event.deltaY*(-40));
    if(event.wheelDelta>0){
        imgScale*=2;
        imgX=imgX*2-pos.x;
        imgY=imgY*2-pos.y;
    }else{
        imgScale/=2;
        imgX=imgX*0.5+pos.x*0.5;
        imgY=imgY*0.5+pos.y*0.5;
    }
    drawImage();
}

function windowToCanvas(canvas,x,y){
    var bbox = canvas.getBoundingClientRect();
    return {
        x:x - bbox.left - (bbox.width - canvas.width) / 2,
        y:y - bbox.top - (bbox.height - canvas.height) / 2
    };
}

