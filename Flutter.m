clc; clear; close 



%Fin Geometry properties
ct = 6 ;%input('Write Tip chord value with inch = ');
cr = 12; %input('Write Root chord value with inch = ');
b = 4.724; %input('Write Semi span value with inch = ');
t = 0.118; %input('Write Fin thickness value with inch = ');

%Variable with respect to altitude
T_ground = 59 ;%input('Write ground temperature value with fahrenheit = ');


%Variable will taken from dataset
A = xlsread('26.xlsx');
Time= A(:,1);
h = A(:,2); %input('Write Altitude value with feet at maximum dynamic pressure = ');
velocity = A(:,3); %input('Write maximum velocity value with feet per second = ');

%Fin material properties
gamma = 1.4;
shear_modul = 425000; %input('Write shear modulus value with psi for material used  = '); %G, psi
R = 1716.9;

%Fin geometry
W_Area = ((cr+ct)/2)*b;
AR = (b^2) / W_Area ;
Lambda = ct/cr ;
T = (T_ground - (0.00356 .* h));
a = (gamma.*R.*(T+460)).^ 0.5 ;
Air_pressure = (2116/144).*(((T+459.7)./518.6).^5.256);

% maxvel = max(velocity, [], 'all');
% 
% minvel = min(velocity, [], 'all');

%Flutter velocity
Top = shear_modul ;
BottomF = ((1.337)*(AR^3)*(Air_pressure)*(Lambda + 1))/(2*(AR +2)*((t / cr)^3)) ;
Flutter_velocity = (a .* sqrt(Top ./ BottomF) ) ;

% maxflutvel = max(Flutter_velocity, [], 'all');
% 
% minflutvel = min(Flutter_velocity, [], 'all');

SafetyFactor_Flutter = (Flutter_velocity ./ velocity);

%Divergence velocity
BottomD = ((3.3 *(Air_pressure))/(1+(2/AR))*((cr+ct)/(t^3))*(b^2));
Divergence_velocity =  (a .* (Top ./ BottomD) .^ 0.5);
 
SafetyFactor_Divergence = (Divergence_velocity ./ velocity);
% maxdivvel = max(Divergence_velocity, [], 'all');
% 
% mindivvel = min(Divergence_velocity, [], 'all');

% MaxDiv =  (maxdivvel ./ minvel); 
MaxDiv = max(SafetyFactor_Divergence, [], 'all')
% MaxFlut = (maxflutvel ./ minvel);
 MaxFlut = max(SafetyFactor_Flutter, [], 'all');

% MinDiv = (mindivvel ./ maxvel); 
MinDiv = min(SafetyFactor_Divergence, [], 'all');
% MinFlut = (minflutvel ./ maxvel); 
MinFlut = min(SafetyFactor_Flutter, [], 'all');

fprintf('Maximum Divergence Velocity Safety factor %d \n', MaxDiv)

fprintf('Maximum Flutter Velocity Safety factor %d \n', MaxFlut)

fprintf('Minimum Divergence Velocity Safety factor %d \n', MinDiv)

fprintf('Minimum Flutter Velocity Safety factor %d \n', MinFlut)

SafetyFactor_Flutter = (Flutter_velocity ./ velocity);

plot(Time,SafetyFactor_Flutter);


%Arda Pamuk, Middle East Technical University Aerospace Engineering
