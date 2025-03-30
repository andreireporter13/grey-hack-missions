// Get access to wifi with script ---> 
// hack everything in GreyHack with scripts !!!

// 
crypto = include_lib("/lib/crypto.so")
crypto.airmon("start", "wlan0")
 
computer = get_shell.host_computer
networks = computer.wifi_networks("wlan0")

network_map = {}
bubble_big = 0

for network in networks
	data = network.split(" ")
	
	// get data from networks
	bssid = data[0]
	essid = data[-1]
	pwr = data[1]
	
	// string_int to int
	pwr = pwr.replace("%", "")
	pwr = pwr.to_int
	
	// get biggest num
	if bubble_big < pwr then
		bubble_big = pwr
	end if
	
	// add data to map
	network_map.push(pwr)
	network_map[pwr] = [bssid, essid]
end for

// Get more powerfull signal - WIFI
print("The most powerfull Wifi Signal:")
print(bubble_big)
print(network_map[bubble_big])

// crack wifi
crypto.aireplay(network_map[bubble_big][0], network_map[bubble_big][1], 5000)

wait(2)
password = crypto.aircrack("/home/return/off_/file.cap")
print(password)

