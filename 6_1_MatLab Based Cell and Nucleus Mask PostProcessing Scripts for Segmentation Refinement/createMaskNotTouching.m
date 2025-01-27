% Copyright (c) 2025, Dominic Filion

function bwf = createMaskNotTouching(Ic)

se = strel('disk',1);
bwf = false(size(Ic));
for i = 1:max(Ic(:))
    bw = Ic==i;
    bwe = imerode(bw,se);
    bwf = bwe|bwf;
end