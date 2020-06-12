# recordkeep

DNS Record retrieval tool. Outputs in a tab delimited format, suitable for pasting into spreadsheets.

```
                      .                 
,-. ,-. ,-. ,-. ,-. ,-| . , ,-. ,-. ,-. 
|   |-' |   | | |   | | |/  |-' |-' | | 
'   `-' `-' `-' '   `-' |\  `-' `-' |-' 
                        ' `         |   
                                    '   
This tool uses 'host -A' to retrieve any and all DNS records belonging to target hosts.

          Use -h To show this message.
          Use -o To specify the file to write to.
          Use -t To specify the file containing the target FQDNs. Delimited by line.

If some FQDNs, which you are certain have associated DNS records, do not return anything, try changing your router's DNS server to a static and reliable one. I recommend 1.1.1.1 (Cloudflare) and 8.8.8.8 (Google).
```

## Examples
```
> cat targets.txt
minecraft.com
minecraft.net

> ./recordkeep.sh -t targets.txt -v
[+] Performing lookup on minecraft.com 
TXT     minecraft.com.  "v=spf1 +a
MX      minecraft.com.  0       minecraft.com.
SOA     minecraft.com.  bns1.hosting-services.net.au.   servers.vip-servers.com.
NS      minecraft.com.  bns3.hosting-services.net.au.
NS      minecraft.com.  bns1.hosting-services.net.au.
NS      minecraft.com.  bns2.hosting-services.net.au.
A       minecraft.com.  110.232.140.74
[+] Performing lookup on minecraft.net 
A       minecraft.net.  99.84.243.36
A       minecraft.net.  99.84.243.62
A       minecraft.net.  99.84.243.65
A       minecraft.net.  99.84.243.50
NS      minecraft.net.  ns-1395.awsdns-46.org.
NS      minecraft.net.  ns-154.awsdns-19.com.
NS      minecraft.net.  ns-2028.awsdns-61.co.uk.
NS      minecraft.net.  ns-575.awsdns-07.net.
SOA     minecraft.net.  ns-1395.awsdns-46.org.  awsdns-hostmaster.amazon.com.
MX      minecraft.net.  0       minecraft-net.mail.protection.outlook.com.
TXT     minecraft.net.  "google-site-verification=ssoFQZt3u8pNjxzZ4p8AQn40jGcR-CCqoiOvLU69oec"
TXT     minecraft.net.  "v=spf1 include:spf.protection.outlook.com
```
