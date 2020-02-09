float r1 = 200;
float r2 = 100;
float m1 = 16;
float m2 = 24;
float a1 = PI/2;
float a2 = PI/3;
float a1_v = 0;
float a2_v = 0;
float a1_acc = 0;
float a2_acc = 0;
float g = 1;

float px2, py2;
float cx, cy;

float friction = 0.995;

int dTime = millis();

PGraphics canvas;

void setup() {
    size(900, 700);
    cx = width/2;
    cy = 100;
    canvas = createGraphics(width, height);
    canvas.beginDraw();
    canvas.background(255);
    canvas.endDraw();
    textSize(14);
}

void draw() {
    float a1_num1 = -g*(2*m1+m2)*sin(a1)-m2*g*sin(a1-2*a2)-2*sin(a1-a2)*m2*(a2_v*a2_v*r2+a1_v*a1_v*r1*cos(a1-a2));
    float a1_num2 = r1*(2*m1+m2-m2*cos(2*a1-2*a2));
    float a2_num1 = 2*sin(a1-a2)*(a1_v*a1_v*r1*(m1+m2)+g*(m1+m2)*cos(a1)+a2_v*a2_v*r2*m2*cos(a1-a2));
    float a2_num2 = r2*(2*m1+m2-m2*cos(2*a1-2*a2));
    
    a1_acc = a1_num1/a1_num2;
    a2_acc = a2_num1/a2_num2;
    
    //background(255);
    image(canvas, 0, 0);
    stroke(0);
    strokeWeight(1);
    
    translate(cx, cy);
    
    float x1 = r1 * sin(a1);
    float y1 = r1 * cos(a1);
    
    float x2 = x1 + r2 * sin(a2);
    float y2 = y1 + r2 * cos(a2);
    
    fill(0, 0, 0, 255);
    line(0, 0, x1, y1);
    ellipse(x1, y1, m1, m1);
    line(x1, y1, x2, y2);
    ellipse(x2, y2, m2, m2);
    
    a1_v += a1_acc;
    a2_v += a2_acc;
    a1 += a1_v;
    a2 += a2_v;
    
    a1_v *= friction;
    a2_v *= friction;

    canvas.beginDraw();
    canvas.translate(cx, cy);
    canvas.strokeWeight(2);
    canvas.stroke(0);
    if (frameCount > 1) {
        canvas.line(px2, py2, x2, y2);
    }
    canvas.endDraw();
    
    px2 = x2;
    py2 = y2;
    
    text("Vel1: " + round(a1_v*1000), -width/2+20, height-180); 
    text("Acc1: " + round(a1_acc*1000), -width/2+20, height-160); 
    text("Vel2: " + round(a2_v*1000), -width/2+20, height-140); 
    text("Acc2: " + round(a2_acc*1000), -width/2+20, height-120); 
}
