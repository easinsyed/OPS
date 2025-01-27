% Copyright (c) 2025, Dominic Filion

cellSize = 40;  % area in pixels
nucleousSize = 20; % area in pixels

d = dir('**\*.png');
% find the files which are Cytoplasm mask
indCell = cell2mat(cellfun(@(x) contains(x,'CellMask'),{d.name},'UniformOutput',false));
indNuc = cell2mat(cellfun(@(x) contains(x,'NucleiMask'),{d.name},'UniformOutput',false));
dc = d(indCell);
dn = d(indNuc);
mkdir(strrep(dc(1).folder,'masks','processedMasks'))
mkdir(strrep(dn(1).folder,'masks','processedMasks'))
hw = waitbar(0);
for i = 1:size(dc,1)
    waitbar(i/size(dc,1),hw);
    cname = strcat(dc(i).folder,'\',dc(i).name);
    nname = strcat(dn(i).folder,'\',dn(i).name);
    Ic = imread(cname);
    In = imread(nname);
    bwc = createMaskNotTouching(Ic);
    bwn = createMaskNotTouching(In);
    bwc = clearCellMask(bwc,cellSize);
    [bwn,bwc] = getOneNucleousPerCell(bwn,bwc,nucleousSize);
    snname = strrep(nname,'.png','.tif');
    snname = strrep(snname,'masks','processedMasks');
    imwrite(bwn,snname,'Compression','none');
    scname = strrep(cname,'.png','.tif');
    scname = strrep(scname,'masks','processedMasks');
    imwrite(bwc,scname,'Compression','none');
end
close(hw);