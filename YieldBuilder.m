%% Heading
%CDT Matthew Eckert
%Using MonteCarlo Script to build a graph of all test data

%% Running MonteCarloYield for all Tests

% Function input is test directory path. I.E. 'test_6\','test_5\'

xvalues = [0:0.01:300];

% test1 = MonteCarloYield('test_1\');
% curve1 = fitmethis(test1.Y,'figure','off','criterion','AIC');
% Test 1 has no phases in its arrival data


test2 = MonteCarloYield('test_2\');
curve2 = fitdist(test2(:), 'birnbaumsaunders');
pdf2 = pdf(curve2, xvalues);
pdf2 = pdf2/sum(pdf2);
% mean2 = mean(test2);
[peak2,peak2x] = max(pdf2);
yieldmax2 = xvalues(peak2x);

test3 = MonteCarloYield('test_3\');
curve3 = fitdist(test3(:), 'birnbaumsaunders');
pdf3 = pdf(curve3, xvalues);
pdf3 = pdf3/sum(pdf3);
% mean3 = mean(test3);
[peak3,peak3x] = max(pdf3);
yieldmax3 = xvalues(peak3x);

test4 = MonteCarloYield('test_4\');
curve4 = fitdist(test4(:), 'birnbaumsaunders');
pdf4 = pdf(curve4, xvalues);
pdf4 = pdf4/sum(pdf4);
% mean4 = mean(test4);
[peak4,peak4x] = max(pdf4);
yieldmax4 = xvalues(peak4x);

test5 = MonteCarloYield('test_5\');
curve5 = fitdist(test5(:), 'birnbaumsaunders');
pdf5 = pdf(curve5, xvalues);
pdf5 = pdf5/sum(pdf5);
% mean5 = mean(test5);
[peak5,peak5x] = max(pdf5);
yieldmax5 = xvalues(peak5x);

test6 = MonteCarloYield('test_6\');
curve6 = fitdist(test6(:), 'birnbaumsaunders');
pdf6 = pdf(curve6, xvalues);
pdf6 = pdf6/sum(pdf6);
% mean6 = mean(test6);
[peak6,peak6x] = max(pdf6);
yieldmax6 = xvalues(peak6x);

figure();

line(xvalues,pdf2,"Color","r",'LineWidth',1.8);
text(yieldmax2+1,peak2+0.00005,"Test 2 Yield Median: 4.7600 kt");
%xline(median2,"--",'Test 2 Mean');
line(xvalues,pdf3,"Color","b",'LineWidth',1.8);
text(yieldmax4+1,peak3+0.00005,"Test 3 Yield Median: 12.3700 kt");
%xline(median3,"--",'Test 3 Mean');
line(xvalues,pdf4,"Color","c",'LineWidth',1.8);
text(yieldmax4+1,peak4+0.00008,"Test 4 Yield Median: 12.1300 kt");
%xline(median4,"--",'Test 4 Mean');
line(xvalues,pdf5,"Color","m",'LineWidth',1.8);
text(yieldmax5+1.1,peak5+0.000047,"Test 5 Yield Median: 16.7100 kt");
%xline(median5,"--",'Test 5 Mean');
line(xvalues,pdf6,"Color","g",'LineWidth',1.8);
text(yieldmax6+1,peak6+0.00005,"Test 6 Yield Median: 102.2200 kt");
%xline(median6,"--",'Test 6 Mean');
xlabel("Yield in kilotons [kt]");
ylabel("Probability");
title("Probability Distributions of Yield for DPRK Test data");
legend("Test2","Test3","Test4","Test5","Test6");
hold off
% Make Histogram plots ------------------------------------------------

figure();
Hist2 = fitmethis(test2);
title("Test 2")
xlabel("Yield [kt]")
ylabel("# of Occurances")
figure();
Hist3 = fitmethis(test3);
title("Test 3")
xlabel("Yield [kt]")
ylabel("# of Occurances")
figure();
Hist4 = fitmethis(test4);
title("Test 4")
xlabel("Yield [kt]")
ylabel("# of Occurances")
figure();
Hist5 = fitmethis(test5);
title("Test 5")
xlabel("Yield [kt]")
ylabel("# of Occurances")
figure();
Hist6 = fitmethis(test6);
title("Test 6")
xlabel("Yield [kt]")
ylabel("# of Occurances")





