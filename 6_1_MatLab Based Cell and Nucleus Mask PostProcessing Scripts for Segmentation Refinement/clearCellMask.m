% Copyright (c) 2025, Dominic Filion

function bwc = clearCellMask(bwc,thSize)

bwc = imclearborder(bwc);
props = regionprops(bwc,'Area');
ind = [props.Area] >= thSize;
bwc = ismember(bwlabel(bwc),find(ind));


