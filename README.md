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

