% Copyright (c) 2025, Dominic Filion

function [bwn,bwc] = getOneNucleousPerCell(bwnIni,bwcIni,thSizeNuc)

bwlc = bwlabel(bwcIni);
bwc = false(size(bwcIni));
bwn = false(size(bwnIni));
for i = 1:max(bwlc(:))
    bw = bwlc==i;
    bws = bw&bwnIni;
    props = regionprops(bws,'Area');
    if size(props,1)>=2
        [~,indMax] = max([props.Area]);
        bws = bwlabel(bws)==indMax;
    end
    if sum(bws(:)) >= thSizeNuc
        bwn = bws|bwn;
        bwc = bw|bwc;
    end
end