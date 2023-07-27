
% Test 2
A.Lower = 369;
A.Upper = 456;
A.pd = makedist('Uniform','Lower',A.Lower,'Upper',A.Upper);
A.range = linspace(300,650,10000); % Plots look weird because of this Range, However we need this to ensure that 0 is never chosen by random for the contants.
A.pdf   = pdf(A.pd,A.range);

%Plot the results
figure();
plot(A.range,A.pdf,'-b','linewidth',1.5);
xlabel('Depth Of Burst [m]'); ylabel('Frequency/density');
title("Test 2")
set(gca,'FontSize',16);

% Test 3
A.Lower = 318;
A.Upper = 407;
A.pd = makedist('Uniform','Lower',A.Lower,'Upper',A.Upper);
A.range = linspace(300,650,10000); % Plots look weird because of this Range, However we need this to ensure that 0 is never chosen by random for the contants.
A.pdf   = pdf(A.pd,A.range);

%Plot the results
figure();
plot(A.range,A.pdf,'-b','linewidth',1.5);
xlabel('Depth Of Burst [m]'); ylabel('Frequency/density');
title("Test 3")
set(gca,'FontSize',16);


% Test 4
A.Lower = 506;
A.Upper = 610;
A.pd = makedist('Uniform','Lower',A.Lower,'Upper',A.Upper);
A.range = linspace(300,650,10000); % Plots look weird because of this Range, However we need this to ensure that 0 is never chosen by random for the contants.
A.pdf   = pdf(A.pd,A.range);

%Plot the results
figure();
plot(A.range,A.pdf,'-b','linewidth',1.5);
xlabel('Depth Of Burst [m]'); ylabel('Frequency/density');
title("Test 4")
set(gca,'FontSize',16);


% Test 5
A.Lower = 475;
A.Upper = 584;
A.pd = makedist('Uniform','Lower',A.Lower,'Upper',A.Upper);
A.range = linspace(300,650,10000); % Plots look weird because of this Range, However we need this to ensure that 0 is never chosen by random for the contants.
A.pdf   = pdf(A.pd,A.range);

%Plot the results
figure();
plot(A.range,A.pdf,'-b','linewidth',1.5);
xlabel('Depth Of Burst [m]'); ylabel('Frequency/density');
title("Test 5")
set(gca,'FontSize',16);


% Test 6
A.Lower = 560;
A.Upper = 636;
A.pd = makedist('Uniform','Lower',A.Lower,'Upper',A.Upper);
A.range = linspace(300,650,10000); % Plots look weird because of this Range, However we need this to ensure that 0 is never chosen by random for the contants.
A.pdf   = pdf(A.pd,A.range);

%Plot the results
figure();
plot(A.range,A.pdf,'-b','linewidth',1.5);
xlabel('Depth Of Burst [m]'); ylabel('Frequency/density');
title("Test 6")
set(gca,'FontSize',16);






