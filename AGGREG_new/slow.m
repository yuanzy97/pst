%  function to do slow coherency aggregation

%  generator data vector and angle
e = [1.10; 1.08];          % internal voltage 
delta = [30; 50]*pi/180;   % rotor angle
m = [7; 5];                % machine inertia (2H)
xdprime = [0.17; 0.21];    % transient reactance

%  bus voltage data
v = [1.01; 1.02];          % voltage
theta = [10; 20]*pi/180;   % angle

while(0)
% identical generators
% generator data vector and angle
e = [1.10; 1.10];          % internal voltage 
delta = [30; 30]*pi/180;   % rotor angle
m = [7; 7];                % machine inertia (2H)
xdprime = [0.17; 0.17];    % transient reactance

%  bus voltage data
v = [1.01; 1.01];          % voltage
theta = [10; 10]*pi/180;   % angle
end

while(0)
%  generator data vector and angle
e = [1.10; 1.08; 1.12; 1.09];          % internal voltage 
delta = [30; 50; 35; 40]*pi/180;   % rotor angle
m = [7; 5; 5; 6];                % machine inertia (2H)
xdprime = [0.17; 0.21; .18; .23];    % transient reactance

%  bus voltage data
v = [1.01; 1.02; 1.00; 0.99];          % voltage
theta = [10; 20; 5; 10]*pi/180;   % angle
end

ngen = length(e);
ma = sum(m);               % aggregate inertia
deltaa = m'*delta/ma;     % aggregate rotor angle
ea = m'*e/ma;              % aggregate voltage

% power generated by machines
pm = e.*v.*sin(delta-theta)./xdprime;

% linearization
K1 = -diag(e.*v.*cos(delta-theta)./xdprime./m);
K2 = [-diag(pm./v./m) -K1];

% slow coherency transformation matrix
T = [m'/ma; -ones(ngen-1,1) eye(ngen-1)]; 
                           % T = [C; G]

% transform K1 and K
Tinv = inv(T);
K1n = T*K1*Tinv;
K2n = T*K2;
jay = sqrt(-1);
K3n = -diag((jay*e.*exp(jay*delta)./(jay*xdprime)))*Tinv;

% extract ma
md = m(1)*m(2:ngen,1)./(m(1)*ones(ngen-1,1)+m(2:ngen,1));
K1n = diag([ma;md])*K1n; K2n = diag([ma;md])*K2n;

% recover line parameters
% aggregate generator
beta1 = -K2n(1,1:ngen);
beta2 = K2n(1,ngen+1:2*ngen);
phia = -(atan2(beta1',beta2'./v) - deltaa*ones(theta) + theta);
ra = sqrt( beta1'.^2 + (beta2'./v).^2 );
tapa = ea./e;
xdprimea = e./ra;
K3na_net=jay*ea./tapa.*exp(jay*(deltaa*ones(delta)-phia)) ...
          ./(jay*xdprimea);

% difference generator
deltad = T(2:ngen,:)*delta;
ed = ea*ones(ngen-1,1);
beta1 = -K2n(2,1:ngen);
beta2 = K2n(2,ngen+1:2*ngen);
phid = -(atan2(beta1',beta2'./v) - deltad*ones(theta) + theta);
rd = sqrt( beta1'.^2 + (beta2'./v).^2 );
tapd = ed./e;
xdprimed = e./rd;
K3nd_net=jay*ea./tapd.*exp(jay*(deltad-phid)) ...
          ./(jay*xdprimed);

% impedance between machines
xad = (ea*ed*cos(deltaa-deltad))/K1n(1,2);

return

% slow aggregate model
invK1n22 = inv(K1n(2:ngen,2:ngen));
K1a = K1n(1,1) - K1n(1,2:ngen)*invK1n22*K1n(2:ngen,1);
K2a = K2n(1,:) - K1n(1,2:ngen)*invK1n22*K2n(2:ngen,:);

% CURRENT FLOW AGGREGATION
jay = sqrt(-1);
K3a = -(jay*e.*exp(jay*delta)./(jay*xdprime)).* ...
       (ones(delta)-Tinv(:,2:ngen)*invK1n22*K1n(2:ngen,1));
K4a = [diag(exp(jay*theta)./(jay*xdprime)) ...
       diag(jay*v.*exp(jay*theta)./(jay*xdprime))] + ...
       diag(jay*e.*exp(jay*delta)./(jay*xdprime))*  ...
       Tinv(:,2:ngen)*invK1n22*K2n(2:ngen,:);


%  