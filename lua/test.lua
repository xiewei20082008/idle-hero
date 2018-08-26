init('0',1);
point = findMultiColorInRegionFuzzyExt(0x9e4833,"23|-21|0x5a1d2e,10|1|0xe17d1f", 100, 0, 0, 1920, 1080,  { main = 0x050505, list = 0x050505 } )
nLog(#point)
for k,v in pairs(point) do
	nLog(v.x..","..v.y)
end

