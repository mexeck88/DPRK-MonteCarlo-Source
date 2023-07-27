%Heading
%CDT Matthew Eckert
%Building the station.dat and arrival.dat files for each test.
%The function will create the files "test_#arrival.dat" and
%"test_#station.dat"
%-----------------------------------------------------------

%BuildBayesloc('test_1\') Test 1 has no Phase Data, cant be used
BuildBayesloc('test_2\');
BuildBayesloc('test_3\');
BuildBayesloc('test_4\');
BuildBayesloc('test_5\');
BuildBayesloc('test_6\');






%% Build Bayesloc Files
function F = BuildBayesloc(testpath)


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
clear i
clear index
%SITE
for i=1:length(fileList)
   if (contains(fileList(i).name,"site.txt")) == 1
    index = i;
   end
end
SiteID = fopen(fileList(index).name);
site = textscan(SiteID,'%-6s %8d %8d %9.4f %9.4f %9.4f %*[^\n]');
fclose(SiteID);

clear directory
clear fileList
%-----------------------------------------------------------------------------------------
%Extract values from ARRIVAL
IPHASE = arrival{8};
STA = arrival{1};
TIME = num2cell(arrival{2});
ARID = num2cell(100);
k = 1;
for i=1:length(arrival{1}) %loop through the array and store specific wave data only
w = IPHASE(i);
if (strcmp(w,"P")) == 1 
    indexarr(k) = i;
    k = k+1;
elseif (strcmp(w,"Pn")) == 1 
    indexarr(k) = i;
    k = k+1; 
elseif (strcmp(w,"Sn")) == 1 
    indexarr(k) = i;
    k = k+1;
elseif (strcmp(w,"PcP")) == 1 
    indexarr(k) = i;
    k = k+1;
elseif (strcmp(w,"PKiKP")) == 1 
    indexarr(k) = i;
    k = k+1;
elseif (strcmp(w,"PKKPbc")) == 1 
    indexarr(k) = i;
    k = k+1;
end
end
clear i
    ArrData(1,1) = cellstr("ev_id");
    ArrData(1,2) = cellstr("sta_id");
    ArrData(1,3) = cellstr("phase");
    ArrData(1,4) = cellstr("time");
for i=2:length(indexarr)
    ArrData(i,1) = ARID;
    ArrData(i,2) = STA(indexarr(i));
    ArrData(i,3) = IPHASE(indexarr(i));
    ArrData(i,4) = TIME(indexarr(i));
end
%------------------------------------------------------------------------------------------
%Extract values from SITE
STA = site{1};
LAT = num2cell(site{4});
LON = num2cell(site{5});
ELEV = num2cell(site{6});
    
    SiteData(1,1) = cellstr("sta_id");
    SiteData(1,2) = cellstr("lat");
    SiteData(1,3) = cellstr("lon");
    SiteData(1,4) = cellstr("elev");
for i=2:length(site{1})
    SiteData(i,1) = STA(i);
    SiteData(i,2) = LAT(i);
    SiteData(i,3) = LON(i);
    SiteData(i,4) = ELEV(i);
end
%------------------------------------------------------------------------------------------
%Remove Sations that aren't used
mask = [];
k=1;
for i = 2:length(ArrData(:,2))
    z = intersect(ArrData(i,2),SiteData(:,1));
    if isempty(z) == 1
        mask(k) = i;
        k=k+1;
    end
end
ArrData(mask,:) = [];

% mask = [];
% k=1;
% for i = 2:length(SiteData(:,1))
%     z = intersect(ArrData(:,2),SiteData(i,1));
%     if isempty(z) == 1
%         mask(k) = i;
%         k=k+1;
%     end
% end
% SiteData(mask,:) = [];

%numb = unique(ArrData(:,2)); Use this to count station number

a = (testpath(1:end-1)) + "arrival.dat";
s = (testpath(1:end-1)) + "station.dat";

cd ..\








F = struct('files',{ArrData,SiteData});
edit(a);
edit(s);
writecell(F(1).files,a,'Delimiter','space');
writecell(F(2).files,s,'Delimiter','space');
%Clear Variables
clear ans
clear ARID
clear arrival
clear ELEV
clear i
clear index
clear indexarr
clear IPHASE
clear k
clear LAT
clear LON
clear site
clear SiteID
clear STA
clear TIME
clear w


end



