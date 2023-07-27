function elevation = elevation_data(location)
% [A,R] = readgeoraster('DEM\gt30e100n40.dem','outputtype','double');
[A1,R1] = readgeoraster('DEM/gt30e100n90.dem','outputtype','double');
x.lat = linspace(R1.LatitudeLimits(1), R1.LatitudeLimits(2),60000);
x.lon = linspace(R1.LongitudeLimits(1), R1.LongitudeLimits(2),4800);
for i = 1:5
    idx = find(x.lat<location.down(i));
    idx1 = find(x.lat>location.up(i));
    idx2 = find(x.lon<location.left(i));
    idx3 = find(x.lon>location.right(i));
    elevation(i).elev = A1(idx2(end):idx3(1),idx(end):idx1(1));
    figure();
    surf(elevation(i).elev);colorbar;
    elevation(i).elev = reshape(elevation(i).elev,[],1);
    minElev = min(elevation(i).elev);
    elevation(i).elev = elevation(i).elev - (minElev-0.1); %adjusted to allow gamma function to work
end
zlimits = [min(A1) max(A1)];

for i = 1:5
    figure();
    hold on
    worldmap([location.down(i) location.up(i)],[location.left(i) location.right(i)]);
    geoshow(A1,R1,'DisplayType','surface');
    demcmap(zlimits); colorbar;
    light
    axis normal
    view(3)
end
figure();
rectangle('Position',[location.left(1) location.down(1)...
    location.width(1) location.height(1)],'Edgecolor',[0 0 1],'LineWidth',3,'LineStyle', ':');
hold on
rectangle('Position',[location.left(2) location.down(2)...
    location.width(2) location.height(2)],'Edgecolor',[0 1 0],'LineWidth',3,'LineStyle', ':');
rectangle('Position',[location.left(3) location.down(3)...
    location.width(3) location.height(3)],'Edgecolor',[1 0 1],'LineWidth',3,'LineStyle', ':');
rectangle('Position',[location.left(4) location.down(4)...
    location.width(4) location.height(4)],'Edgecolor',[0 1 1],'LineWidth',3,'LineStyle', ':');
rectangle('Position',[location.left(5) location.down(5)...
    location.width(5) location.height(5)],'Edgecolor',[1 1 1],'LineWidth',3,'LineStyle', ':');
end