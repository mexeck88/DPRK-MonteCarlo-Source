%% Heading
% CDT Matthew Eckert
%All in one script to generate DOB for each Test
%Requires MonteMinDOB.m, DOBBuilder.m, location_analysis.m,
%elevation_data.m

%% Elevation Analysis

TestLoc = location_analysis;
TestElev = elevation_data(TestLoc); 

%% Histograms - Takes a while


DOBdata = DOBBuilder;

xvalues = [0:800];
bins = 200;

curve2 = fitdist(TestElev(1).elev, 'GeneralizedExtremeValue');
pdf2 = pdf(curve2, xvalues);
pdf2 = pdf2/sum(pdf2);
figure();
fitmethis(TestElev(1).elev);

% figure();
% hist2E = histogram(TestElev(1).elev,bins);
xlabel('Elevation [m]'); ylabel('Cumulative % Occurance');
title("Histogram Fit of Test 2 Depth Analysis")
set(gca,'FontSize',13);


curve3 = fitdist(TestElev(2).elev, 'GeneralizedExtremeValue');
pdf3 = pdf(curve3, xvalues);
pdf3 = pdf3/sum(pdf3);
figure();
fitmethis(TestElev(2).elev);

% figure();
% hist3E = histogram(TestElev(2).elev,bins);
xlabel('Elevation [m]'); ylabel('Cumulative % Occurance');
title("Histogram of Test 3 Depth Analysis")
set(gca,'FontSize',13);


curve4 = fitdist(TestElev(3).elev, 'Weibull');
pdf4 = pdf(curve4, xvalues);
pdf4 = pdf4/sum(pdf4);
figure();
fitmethis(TestElev(3).elev);

% figure();
% hist4E = histogram(TestElev(3).elev,bins);
xlabel('Elevation [m]'); ylabel('Cumulative % Occurance');
title("Histogram of Test 4 Depth Analysis")
set(gca,'FontSize',13);


curve5 = fitdist(TestElev(4).elev, 'Nakagami');
pdf5 = pdf(curve5, xvalues);
pdf5 = pdf5/sum(pdf5);
figure();
fitmethis(TestElev(4).elev);

% figure();
% hist5E = histogram(TestElev(4).elev,bins);
xlabel('Elevation [m]'); ylabel('Cumulative % Occurance');
title("Histogram of Test 5 Depth Analysis")
set(gca,'FontSize',13);


curve6 = fitdist(TestElev(5).elev, 'GeneralizedExtremeValue');
pdf6 = pdf(curve6, xvalues);
pdf6 = pdf6/sum(pdf6);
figure();
fitmethis(TestElev(5).elev);

% figure();
% hist6E = histogram(TestElev(5).elev,bins);
xlabel('Elevation [m]'); ylabel('Cumulative % Occurance');
title("Histogram of Test 6 Depth Analysis")
set(gca,'FontSize',13);


minDOBpdf2 = DOBdata.DOB2;
minDOBpdf3 = DOBdata.DOB3;
minDOBpdf4 = DOBdata.DOB4;
minDOBpdf5 = DOBdata.DOB5;
minDOBpdf6 = DOBdata.DOB6;

%% Lets do some Bayes!

%Test 2


% Known Range
A.Lower = 369;
A.Upper = 456;
x1 = A.Upper - ((A.Upper-A.Lower)/2);
err = ((A.Upper-A.Lower)/2);

DOB2 = (minDOBpdf2.*pdf2)./sum(minDOBpdf2.*pdf2);
figure();
hold on
plot(xvalues,pdf2,'r--');
plot(xvalues,minDOBpdf2,'g--');
plot(xvalues,DOB2,'b','LineWidth',2);
errorbar(x1,0.01,err, "horizontal");
%plot(A.range,A.pdf,'m--');
xlabel("Depth of Burst [m]");
ylabel("Frequency");
title("Test 2")
xlim([0 500]);




%Test 3

A.Lower = 318;
A.Upper = 407;
x1 = A.Upper - ((A.Upper-A.Lower)/2);
err = ((A.Upper-A.Lower)/2);

DOB3 = (minDOBpdf3.*pdf3)./sum(minDOBpdf3.*pdf3);
figure();
hold on
plot(xvalues,pdf3, 'r--');
plot(xvalues,minDOBpdf3, 'g--');
plot(xvalues,DOB3,'b','LineWidth',2);
errorbar(x1,0.011,err,"horizontal");
%plot(A.range,A.pdf,'m--');
xlabel("Depth of Burst [m]");
ylabel("Frequency");
legend("Elevation Analysis","Minimum DOB","DOB","Accepted Value")
title("Test 3")
xlim([0 480]);


%Test 4

A.Lower = 506;
A.Upper = 610;
x1 = A.Upper - ((A.Upper-A.Lower)/2);
err = ((A.Upper-A.Lower)/2);

DOB4 = (minDOBpdf4.*pdf4)./sum(minDOBpdf4.*pdf4);
figure();
hold on
plot(xvalues,pdf4,'r--');
plot(xvalues,minDOBpdf4,'g--');
plot(xvalues,DOB4,'b','LineWidth',2);
errorbar(x1,0.0079,err,"horizontal");
%plot(A.range,A.pdf,'m--');
xlabel("Depth of Burst [m]");
ylabel("Frequency");
title("Test 4")
xlim([0 640]);


%Test 5

A.Lower = 475;
A.Upper = 584;
x1 = A.Upper - ((A.Upper-A.Lower)/2);
err = ((A.Upper-A.Lower)/2);

DOB5 = (minDOBpdf5.*pdf5)./sum(minDOBpdf5.*pdf5);
figure();
hold on
plot(xvalues,pdf5,'r--');
plot(xvalues,minDOBpdf5,'g--');
plot(xvalues,DOB5,'b','LineWidth',2);
errorbar(x1,0.008,err,"horizontal");
%plot(A.range,A.pdf,'m--');
xlabel("Depth of Burst [m]");
ylabel("Frequency");
title("Test 5")
xlim([0 640]);


%Test 6

A.Lower = 560;
A.Upper = 636;
x1 = A.Upper - ((A.Upper-A.Lower)/2);
err = ((A.Upper-A.Lower)/2);

DOB6 = (minDOBpdf6.*pdf6)./sum(minDOBpdf6.*pdf6);
figure();
hold on
plot(xvalues,pdf6,'r--');
plot(xvalues,minDOBpdf6,'g--');
plot(xvalues,DOB6,'b','LineWidth',2);
errorbar(x1,0.03,err,"horiztonal");
%plot(A.range,A.pdf,'m--');
xlabel("Depth of Burst [m]");
ylabel("Frequency");
title("Test 6")
xlim([0 700]);

