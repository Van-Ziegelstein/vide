# vide

Automatically search for web servers in `.xml` results of `nmap` data and lightly scan them using `nikto`, `nuclei`, `whatweb` or `ffuf` and also take screenshots using `chromium`

        _______________
    ==c(___(o(______(_()
            \=\
             )=\
            //|\\   ~vide~ high-level web server enumeration
           //|| \\  
          // ||  \\
         //  ||   \\
        //         \\

This is yet another ctf/engagement automation tool, born out of curiosity and boredom

## Usage

```bash
$ nmap target -oA target/nmap/init
[...]

$ tree target 
target
└── nmap
    ├── init.gnmap
    ├── init.nmap
    └── init.xml

$ ./vide -h
usage: vide -d <path to directory with 'nmap' folder>
       [-h]                          show this message
       [-w]                          enable [w]hatweb scan
       [-i]                          enable nucle[i] scan
       [-o]                          enable nikt[o] scan
       [-f]                          enable directory brute [f]orcing
       [-s]                          enable [s]creenshotting
       [-p <path to webservers.txt>] [p]ass list of servers to process <PROTO>://<IP>[:<PORT>]

$ ./vide -d target -woisf
[...]

$ tree target
target/
├── nmap
│   ├── host_port.txt
│   ├── init.gnmap
│   ├── init.nmap
│   └── init.xml
└── vide_<DATE>
    ├── webservers.txt
    ├── ffuf
    │   └── 127.0.0.1_9090.html
    ├── httpx
    │   └── scan.log
    ├── nikto
    │   └── 127.0.0.1_9090.html
    ├── nuclei
    │   └── http
    │       └── 127.0.0.1:9090
    │           └── [...].md
    ├── screenshots
    │   └── http
    │       └── 127.0.0.1_9090.pdf
    └── whatweb
        └── 127.0.0.1_9090
            ├── brief.log
            └── deep.log
```

![demo](https://github.com/dreizehnutters/vide/blob/main/assets/demo.gif)

---

## Installation

```bash
$ git clone https://github.com/dreizehnutters/vide
```

## Requirements

+ `/usr/bin/xmlstarlet`
+ `$GO_PATH/bin/httpx`
+ `/usr/bin/chromium`
+ `/usr/bin/whatweb`
+ `$GO_PATH/bin/nuclei`
+ `/usr/bin/nikto`
+ `/usr/bin/ffuf`
---

## Features

- `httpx` 		[used for web server identification](https://github.com/projectdiscovery/httpx)
- `chromium` 	[used for taking screenshots](https://github.com/chromium/chromium)
- `whatweb` 	[used for web server scanning](https://github.com/urbanadventurer/WhatWeb)
- `nuclei` 		[used for web server scanning](https://github.com/projectdiscovery/nuclei)
- `nikto` 		[used for web server scanning](https://github.com/sullo/nikto)
- `ffuf` 		[used for directory brute forcing](https://github.com/ffuf/ffuf)