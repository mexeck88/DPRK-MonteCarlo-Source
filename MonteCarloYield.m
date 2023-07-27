% Heading
%CDT Matthew Eckert
%Estimating Yield from DPRK test data from WFNE using Monte Carlo with
%body wave data
%-----------------------------------------------------------

function  F= MonteCarloYield(testpath)
% Loading Data and Forming Matricies / Variables

directory = testpath;
% List all files
fileList = dir([directory]); 
cd(directory) %Change to test_6\

%Form Matrix
%-------------------------------------------------------------------------------------------------------------------
%ARRIVAL
for i=1:length(fileList)
   if (contains(fileList(i).name,"arrival.txt")) == 1
    index = i;
   end
end
arrivalID = fopen(fileList(index).name);
arrival = textscan(arrivalID,'%-6s %17.5f %10d %8d %10d %8d %-8s %-8s %-1s %6.3f %7.2f %7.2f %7.2f %7.2f %7.2f %7.3f %10.2f %7.2f %7.2f %-1s %-2s %10.2f %-1s %-15s %10d %-17s %d:%d:%d');
fclose(arrivalID);

clear directory
clear fileList
%-----------------------------------------------------------------------------------------
%Extract AMP and PER from ARRIVAL
IPHASE = arrival{8};
AMP = arrival{17};
PER = arrival{18};
k = 1;
for i=1:length(arrival) %loop through the array and store P wave data only
w = IPHASE(i);
if (strcmp(w,"P")) == 1 %No Pn or Pg or any wave other then main mantle P wave.
    indexarr(k) = i;
    k = k+1;
end 
end
clear i
for i=1:length(indexarr)
    Pamp(i) = AMP(i);
    PPer(i) = PER(i);
end
%Need to remove all data with a -1 in amp or period.
i=1;
Y=length(Pamp);
while(i<Y) %Dynamic Loop as length(Pamp) changes per loop
 s = Pamp(i);
 if (contains(string(s),"-1")) == 1
    Pamp(:,i) = [];
    PPer(:,i) = [];
    Y=length(Pamp);
 end
 Y=length(Pamp);
 i = i+1;
end
i=1;
Y=length(Pamp);
while(i<Y)
 c = PPer(i);
  if (contains(string(c),"-1")) == 1
    Pamp(:,i) = [];
    PPer(:,i) = [];
  end
 Y=length(Pamp);
 i = i+1;
end
%Create final array of Log(A/T)
for i=1:length(PPer)
    LOGAT(1,i) = real(log10((Pamp(i)/PPer(i))));
    %Body Wave magnitude Extracted from Test 6 Data.
end
%Clear Variables
clear arrival
clear arrivalID
clear k
clear i
clear IPHASE
clear Pamp
clear PPer
clear PER
clear AMP
clear TIMEOA
clear w
clear ToA
clear indexarr
clear Y
cd ..\

% Monte Carlo - Plot Constants and Mb
%Create Uniform Distrbutions for Geological constants

% Input Constant A given a uniform distribution
A.Lower = 3.92;
A.Upper = 4.45;
A.pd = makedist('Uniform','Lower',A.Lower,'Upper',A.Upper);
A.range = linspace(3.5,5,10000); % Plots look weird because of this Range, However we need this to ensure that 0 is never chosen by random for the contants.
A.pdf   = pdf(A.pd,A.range);
A.pdf   = A.pdf/sum(A.pdf);
A.cdf   = cdf(A.pd,A.range);

%Plot the results
% figure();
% plot(A.range,A.pdf,'-b','linewidth',1.5);
% xlabel('Constant A for Body Wave Equation PDF'); ylabel('Frequency/density');
% set(gca,'FontSize',16);
% 
% figure();
% plot(A.range,A.cdf,'--b','linewidth',1.5);
% xlabel('Constant A for Body Wave Equation CDF'); ylabel('Cumulative % Occurance');
% set(gca,'FontSize',16);


% Input Constant B given a uniform distribution
B.Lower = 0.75;
B.Upper = 0.81;
B.pd = makedist('Uniform','Lower',B.Lower,'Upper',B.Upper);
B.range = linspace(0.5,1,10000); %Plots look weird because of this Range, However we need this to ensure that 0 is never chosen by random for the contants.
B.pdf   = pdf(B.pd,B.range);
B.pdf   = B.pdf/sum(B.pdf);
B.cdf   = cdf(B.pd,B.range);

%Plot the results
% figure();
% plot(B.range,B.pdf,'-r','linewidth',1.5);
% xlabel('Constant B for Body Wave Equation PDF'); ylabel('Frequency/density');
% set(gca,'FontSize',16);
% 
% figure();
% plot(B.range,B.cdf,'--r','linewidth',1.5);
% xlabel('Constant B for Body Wave Equation CDF'); ylabel('Cumulative % Occurance');
% set(gca,'FontSize',16)

% Monte Carlo - Execution for Constants and Mb
% May take a few seconds to run.

% Randomly select A variable for each n_trials
n_trials        = 100000;
random          = rand(n_trials,1);
for i = 1:n_trials
    ida                = find(A.cdf>random(i,1));
    simulation.a(i)    = A.range(ida(1));
end
bins                  = 1000;

% Plot Results
% figure();
% histogram(simulation.a,bins);
% title("Histogram of simulation for Constant A")

% Randomly select B variable for each n_trials
n_trials        = 100000;
random          = rand(n_trials,1);
for i = 1:n_trials
    idb                = find(B.cdf>random(i,1));
    simulation.b(i)    = B.range(idb(1));
end
bins                  = 1000;

% Plot Results
% figure();
% histogram(simulation.b,bins);
% title("Histogram of simulation for Constant B")

% Monte Carlo - Execution for Yield
%---------------------------------------------------------------------------------------------------------------------------------
%Simulation Using non simulated Body Wave magnitude
bins = 100;
n_trials        = 100000;
Mb2 = randsample((LOGAT(1)+2), n_trials,true);  %Turn LOGAT into a suitable arary for monte carlo. 2 is the "corrective constant". Could not find a WFNE value for this constant.
for i = 1:n_trials
    
    simulation.Y(i) = 10^(((Mb2(i))-simulation.a(i))/simulation.b(i));
end


F = simulation.Y;

% % Plot the results
% figure();
% histogram(simulation.Y,bins);
% % xlim([0, 1000])
% xlabel('Output Yield'); ylabel('Cumulative % Occurance');
% title("Histogram of Yield w/ no ToA Preference[Tonnes?]")
% set(gca,'FontSize',16);

clear s
clear A
clear B
clear and
clear bins
clear c
clear i
clear ida
clear idb
clear n_trials
clear random
clear LOGAT
clear Mb2
end




