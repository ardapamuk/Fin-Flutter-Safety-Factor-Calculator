clc; clear; close 
syms Time

%Fin Geometry properties
ct = input('Write Tip chord value with inch = ');
cr = input('Write Root chord value with inch = ');
b = input('Write Semi span value with inch = ');
t = input('Write Fin thickness value with inch = ');

%Variable with respect to altitude
T_ground = input('Write ground temperature value with fahrenheit = ');

%Variable will taken from dataset
h = input('Write Altitude value with feet at maximum dynamic pressure = ');
velocity = input('Write maximum velocity value with feet per second = ');

%Fin material properties
gamma = 1.4;
shear_modul = input('Write shear modulus value with psi for material used  = '); %G, psi
R = 1716.9;

%Fin geometry
W_Area = ((cr+ct)/2)*b;
AR = (b^2) / W_Area ;
Lambda = ct/cr ;
T = (T_ground - (0.00356*h));
a = (gamma*R*(T+460))^0.5 ;
Air_pressure = (2116/144)*(((T+459.7)/518.6)^5.256);

%Flutter velocity
Top = shear_modul ;
BottomF = ((1.337)*(AR^3)*(Air_pressure)*(Lambda + 1))/(2*(AR +2)*((t / cr)^3)) ;
Flutter_velocity = (a *(Top / BottomF)^0.5);
SafetyFactor_Flutter = (Flutter_velocity / velocity);

%Divergence velocity
BottomD = ((3.3*(Air_pressure))/(1+(2/AR))*((cr+ct)/(t^3))*(b^2));
Divergence_velocity =  (a * (Top / BottomD)^0.5);
SafetyFactor_Divergence = (Divergence_velocity / velocity) ;

figure(1)
plot(Time,SafetyFactor_Divergence);
xlabel('Time period')
ylabel('SafetyFactor_Divergence')
title('Divergence velocity Safety factor distrubition');

figure(2)
plot(Time,SafetyFactor_Divergence);
xlabel('Time period')
ylabel('SafetyFactor_Flutter')
title('Flutter velocity Safety factor distrubition');

MaxDiv = max(SafetyFactor_Divergence, [], 'all');
MaxFlut = max(SafetyFactor_Flutter, [], 'all');

MinDiv = min(SafetyFactor_Divergence, [], 'all');
MinFlut = min(SafetyFactor_Flutter, [], 'all');

fprintf('Maximum Divergence Velocity Safety factor %d', MaxDiv)

fprintf('Maximum Flutter Velocity Safety factor %d', MaxFlut)

fprintf('Minimum Divergence Velocity Safety factor %d', MinDiv)

fprintf('Minimum Flutter Velocity Safety factor %d', MinFlut)


%Arda Pamuk, Middle East Technical University Aerospace Engineering
