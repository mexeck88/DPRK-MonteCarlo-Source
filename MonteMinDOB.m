% Heading
%NCDT Matthew Eckert
%Estimating minDOB from DPRK test data yield estimations from WFNE
%-----------------------------------------------------------

function  F= MonteMinDOB(testdata)
% Loading Data and Forming Matricies / Variables

%Load yield data
testnum = testdata(1:5);
YIELD = load(testdata);
YIELD = YIELD.(testnum);

% Monte Carlo - Plot Constants and yield 
%Create Uniform Distrbutions for Geological constants

% Input Constant Alpha given a uniform distribution
A.Lower = 3;
A.Upper = 3.4;
A.pd = makedist('Uniform','Lower',A.Lower,'Upper',A.Upper);
A.range = linspace(2.5,4,10000); % Plots look weird because of this Range, However we need this to ensure that 0 is never chosen by random for the contants.
A.pdf   = pdf(A.pd,A.range);
A.pdf   = A.pdf/sum(A.pdf);
A.cdf   = cdf(A.pd,A.range);

%Plot the results
% figure();
% plot(A.range,A.pdf,'-b','linewidth',1.5);
% xlabel('Constant A for DOB PDF'); ylabel('Frequency/density');
% set(gca,'FontSize',16);

% Input Constant C given a uniform distribution
C.Lower = 80;
C.Upper = 110;
C.pd = makedist('Uniform','Lower',C.Lower,'Upper',C.Upper);
C.range = linspace(110,135,10000); %Plots look weird because of this Range, However we need this to ensure that 0 is never chosen by random for the contants.
C.pdf   = pdf(C.pd,C.range);
C.pdf   = C.pdf/sum(C.pdf);
C.cdf   = cdf(C.pd,C.range);

%Plot the results
% figure();
% plot(C.range,C.pdf,'-r','linewidth',1.5);
% xlabel('Constant C for DOB PDF'); ylabel('Frequency/density');
% set(gca,'FontSize',16);


% Monte Carlo - Execution for Constants and yield
% May take a few seconds to run.

% Randomly select Alpha variable for each n_trials
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

% Randomly select C variable for each n_trials
n_trials        = 100000;
random          = rand(n_trials,1);
for i = 1:n_trials
    idc                = find(C.cdf>random(i,1));
    simulation.c(i)    = C.range(idc(1));
end
bins                  = 1000;

% Plot Results
% figure();
% histogram(simulation.b,bins);
% title("Histogram of simulation for Constant B")

% Monte Carlo - Execution for Min DOB
%---------------------------------------------------------------------------------------------------------------------------------
%Simulation
bins = 100;
n_trials        = 100000;
yield = randsample((YIELD), n_trials,true);  %Turn yield into a suitable arary for monte carlo.
for i = 1:n_trials
    c = simulation.c(i);
    y = yield(i);
    a = simulation.a(i);

    
    simulation.minDOB(i) = c*(y^(1/a));
end

F = simulation.minDOB;

% % Plot the results
% figure();
% histogram(simulation.minDOB,bins);
% % xlim([0, 1000])
% xlabel('Output Yield'); ylabel('Cumulative % Occurance');
% title("Histogram of minDOB")
% set(gca,'FontSize',16);

end




