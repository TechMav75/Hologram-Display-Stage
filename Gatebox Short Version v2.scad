$fn=360;


BASE_DIA=200;
BASE_HEIGHT=40;
END_DIA=180;
WALL=5;
MIRROR=[85,100];
PROJECTOR=[104,130,38,29];  //Width, Depth, Thickness, Beam Center from Left Edge
REARSUPPORT=[35,100];
SCREW=[3,3.5,6.5];

FullUnit() ;
//mirror([0,0,1])  
//rotate([0,90,0]) 
//NewFrame(260,10);
//translate([0,0,5]) mirror([0,0,1]) LowerStage() ;
//Coupler() ;
//UpperRearSupport() ;

module FullUnit() {
    mirror([0,0,1]) 
    translate([0,0,-45]) Base() ;
    
    translate([0,0,50]) mirror([0,0,1])  LowerStage() ;
    translate([0,0,49]) NewFrame(260,10);

    translate([65,-50,0])  LowerRearSupport() ;
    /*
    translate([65,-50,183.5])  UpperRearSupport() ;
    translate([70,-45,168.5])  Coupler() ;
    
    //translate([0,0,312.5]) rotate([180,0,0]) UpperDisplayEnd() ;
    translate([0,0,307.5]) UpperStage() ;

    translate([0,0,309]) mirror([0,0,1])NewFrame(260,10);
*/
}

module NewFrame(H,OFFSET) {
    difference() {
        union() {
            difference() {
                cylinder(d=END_DIA,h=H); //Ouside
                translate([0,0,-0.1]) cylinder(d=END_DIA-WALL*2,h=H+1); //Inner Cut
                translate([-END_DIA/2,-END_DIA/2,-0.1]) cube([END_DIA/2-OFFSET,END_DIA,H+1]); //Front Cut
                translate([65,-50,-0.1]) cube([35,100,H+1]);
            }
            translate([-10,-END_DIA/2+1,0]) Frame();  //Add the Frame
            translate([-4.5,-END_DIA/2+1,0]) Frame();  //Add the Frame
        }
    translate([-END_DIA/2,-END_DIA/2,H/2])cube([END_DIA,END_DIA,END_DIA]);  //Cut in half 
    translate([0,-END_DIA/2+WALL/2,H/2-10]) cylinder(d=2,h=20);  //Filament pin
    translate([0,END_DIA/2-WALL/2,H/2-10]) cylinder(d=2,h=20);  //Filament Pin
    rotate([0,0,-45]) translate([0,END_DIA/2-WALL/2,H/2-10]) cylinder(d=2,h=20);  //Rear Filament Pin
    rotate([0,0,-135]) translate([0,END_DIA/2-WALL/2,H/2-10]) cylinder(d=2,h=20);  //Rear Filament Pin
    }

}

module Base() {
difference() {
    hull() {
        cylinder(d=END_DIA,h=WALL);  //'Top' of Base
        translate([0,0,BASE_HEIGHT]) cylinder(d=BASE_DIA,h=WALL);  //'Bottom' of base
        }
    translate([0,0,WALL]) 
        hull() {  //Base Hollow-out
            cylinder(d=BASE_DIA-30,h=WALL);
            translate([0,0,BASE_HEIGHT]) cylinder(d=BASE_DIA-10,h=WALL);
        }
        cylinder(d=END_DIA-WALL*2,h=WALL);  //Remove the top of the base
        translate([65,-(REARSUPPORT[1])/2,-50])  cube([REARSUPPORT[0],REARSUPPORT[1],100]);  //Rear Support Cut  
    }
}         

module LowerDisplayEnd() {
    difference() {
        sphere(d=END_DIA);  //Sphere
        sphere(d=END_DIA-WALL*2);  //Hollow out
        translate([-END_DIA/2,-END_DIA/2,0]) cube([END_DIA,END_DIA,END_DIA]);  //Half Cut
        translate([65,-(REARSUPPORT[1]+1)/2,-70])  cube([REARSUPPORT[0]+1,REARSUPPORT[1]+1,100]);  //Rear Cutout
    
        translate([55,20,-58]) rotate([0,90,0]) cylinder(d=SCREW[1],h=20);  //Rear Screw Hole
        translate([55,-20,-58]) rotate([0,90,0]) cylinder(d=SCREW[1],h=20);  //Rear Screw Hole
        translate([0,0,-45]) rotate([90,0,210]) cylinder(d=SCREW[1],h=120);  //Screw Hole
        translate([0,0,-45]) rotate([90,0,330]) cylinder(d=SCREW[1],h=120);  //Screw Hole
    
    // Counterbores to give flat surfaces for the screws
        translate([55,20,-58]) rotate([0,90,0]) cylinder(d=SCREW[2],h=7);  //Rear Screw Hole
        translate([55,-20,-58]) rotate([0,90,0]) cylinder(d=SCREW[2],h=7);  //Rear Screw Hole
        translate([0,0,-45]) rotate([90,0,210]) cylinder(d=SCREW[2],h=74);  //Screw Hole
        translate([0,0,-45]) rotate([90,0,330]) cylinder(d=SCREW[2],h=74);  //Screw Hole
    }
}

module UpperDisplayEnd() {
    difference() {
        sphere(d=END_DIA);  //Sphere
        sphere(d=END_DIA-WALL*2);  //Hollow Out
        translate([-END_DIA/2,-END_DIA/2,0]) cube([END_DIA,END_DIA,END_DIA]);  //Half Cut
        translate([65,-(REARSUPPORT[1]+1)/2,-70])  cube([REARSUPPORT[0]+1,REARSUPPORT[1]+1,100]);  //Rear Cutout
        translate([55,20,-58]) rotate([0,90,0]) cylinder(d=SCREW[1],h=20);  //Rear Screw Hole
        translate([55,-20,-58]) rotate([0,90,0]) cylinder(d=SCREW[1],h=20);  //Rear Screw Hole
        translate([70,75,-5]) rotate([90,0,0]) cylinder(d=SCREW[0],h=150);  //Side Screw Hole
            // Counterbores to give flat surfaces for the screws
        //translate([55,20,-58]) rotate([0,90,0]) cylinder(d=SCREW[2],h=7);  //Rear Screw Hole
        //translate([55,-20,-58]) rotate([0,90,0]) cylinder(d=SCREW[2],h=7);  //Rear Screw Hole
        translate([70,75,-5]) rotate([90,0,0]) cylinder(d=SCREW[2],h=22);  //Side Screw Hole
        translate([70,-53,-5]) rotate([90,0,0]) cylinder(d=SCREW[2],h=22);  //Side Screw Hole
    }  
}

module Support() {
    difference() {
        translate([70,-10,0]) cube([20,20,80]);  //Body
        translate([0,0,BASE_DIA/2]) sphere(d=END_DIA);  //Sphere cut for curve
        translate([BASE_DIA/2-20,0,-WALL]) cylinder(d=SCREW[0],h=20);  //Screw Holes
        translate([0,0,BASE_DIA/2-45]) rotate([90,0,90]) cylinder(d=SCREW[0],h=85);  //Screw
    }    
}

module LowerRearSupport() {
    difference() {
        cube([40,100,183.5]);  //Body
        translate([WALL,WALL,0]) cube([30,90,210]);  //Hollow Out
        translate([-5,5,-0.1]) cube([25,90,40]);  //Lower Cut
        translate([35/2,-10,178.5]) rotate([270,0,0]) cylinder(d=SCREW[1],h=125);  //Upper Screw
    }
}

module Coupler() {
    difference() {
        cube([30,90,30]);
        translate([2,2,-0.1]) cube([25,85,35]);
        translate([25/2,-10,10]) rotate([270,0,0]) cylinder(d=SCREW[0],h=125);  //Lower Screw Hole
        translate([25/2,-10,20]) rotate([270,0,0]) cylinder(d=SCREW[0],h=125);  //Upper Screw Hole
    }
}

module UpperRearSupport() {
    difference() {
        cube([40,100,195]);  //Body
        translate([WALL,WALL*2,-0.1]) cube([30,80,193]);  //Hollow Out Main Body
        translate([WALL,WALL,-0.1]) cube([30,90,100]);  //Hollow Out  Lower area for coupler
        translate([WALL,WALL,-0.1]) cube([10,90,150]);  //Hollow Out Cable Channel
        translate([0,80,135]) cube([15,15,25]);  //Hollow Out  Cable Passthrough
        translate([-5,10,50]) cube([25,80,128]);  //Mirror Cut 
        //translate([28,7,70])rotate([0,-16,0]) cube([2.5,86,150]);  //Mirror Slot Full Mirror
        //translate([19,7,102])rotate([0,-16,0]) cube([2.5,86,150]);  //Mirror Slot  Small Mirror Front
        translate([32,7,102])rotate([0,-16,0]) cube([2.75,86,150]);  //Mirror Slot  Small Mirror Front
        //translate([-10,30,187]) rotate([0,90,0]) cylinder(d=SCREW[0],h=20);  //Hemisphere Screw Hole
        //translate([-10,70,187]) rotate([0,90,0]) cylinder(d=SCREW[0],h=20);  //Hemisphere Screw Hole
        translate([35/2,-10,5]) rotate([270,0,0]) cylinder(d=SCREW[1],h=125);  //Lower Coupler Screw
        translate([5,-10,134]) rotate([270,0,0]) cylinder(d=SCREW[0],h=125);  //Side Screw Hole
    }
           

}

module Frame() {  //Display Frame
    difference() {
        cube([2,END_DIA-2,260]);
        translate([-0.1,9,5]) cube([6,160,250]);
    }
}

module LowerStage() {
    difference() {
        union() {
            cylinder(d=END_DIA,h=WALL);  //Visable Plate
            cylinder(d=END_DIA-WALL*2,h=WALL*1.5);  //Internal Part
        }
        translate([65,-50.5,-0.1]) cube([120,101,50]);  //Rear Support Cutout
    }
}

module UpperStage() {
    difference() {
        LowerStage() ;
        translate([20,-50,-0.1]) cube([120,100,50]);  //Beam Cutout

    }
}



module Projector() {
    cube([PROJECTOR[0],PROJECTOR[1],PROJECTOR[2]]);
    translate([0,PROJECTOR[3],PROJECTOR[2]/2]) rotate([0,90,0]) cylinder(d=5,h=150);
}


//translate([-80,-PROJECTOR[3],410]) Projector();