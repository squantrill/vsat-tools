#Download sat channel data to allow successeful calibration of vsat equipment
#
#Taken from Thrane Thrane manual:
#Satellite requirements for successful calibration
#Elevation Elevation angle: 5 – 70 degrees
#       Not allowed for calibration: Inclined orbit.
#
#System encryption DVB-S or DVB-S2 Polarisation Horizontal or vertical polarisation.
#       Not allowed: Left-hand circular (L) or right-hand circular (R).
#
#Symbol rate The DVB symbol rate must be >5 Ms/s.
#
#NID Preferably a unique NID (ONID). An azimuth calibration without
#NID can be useful in regions where the satellite operators do not broadcast NID
#(US, China, Australia etc.). For NID=0 the NID is not used when checking the satellite link.

#Bear in mind the beams in your location this script does not do that, if in doubt check the king of sat website

## declare satellites that you want a list of channels from 
declare -a arr=("0.8W" "1.0W" "19.2E" "28.2E" "13.0E")

for i in "${arr[@]}"
do
#Download the sat data
        wget --no-check-certificate -O $i.txt "http://de.kingofsat.net/dl.php?pos=$i&fkhz=0"
#Remove the circular polarisation
        sed -i.bak '/,R,/d' ./$i.txt
        sed -i.bak '/,L,/d' ./$i.txt
#Only include the DVB-S or DVB-S2
        grep -i 'DVB-S\|\S2' $i.txt > $i-DVBS.txt
        mv $i-DVBS.txt $i.txt
done
