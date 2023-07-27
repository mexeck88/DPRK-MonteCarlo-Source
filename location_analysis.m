function  location = location_analysis
sigma          = 2.5; %Sigma ranged from 4 to 1.9
filename       = 'origins_ned_stats.txt';
opts           = detectImportOptions(filename);
data           = readtable(filename,opts);
lat            = table2array(data(:,2));
lon            = table2array(data(:,3));
height         = km2deg(table2array(data(:,6)));
width          = km2deg(table2array(data(:,7)));
height_km      = sigma*table2array(data(:,6));
width_km       = sigma*table2array(data(:,7));
for i = 1:5 %Only one test at a time
    down(1,i)   = lat(i)-((sigma/2)*height(i));
    up(1,i)     = lat(i)+((sigma/2)*height(i));
    left(1,i)   = lon(i)-((sigma/2)*width(i));
    right(1,i)  = lon(i) +((sigma/2)*width(i));
end
location.left   = left;
location.down   = down;
location.up     = up;
location.right  = right;
location.height = height;
location.width  = width;
end