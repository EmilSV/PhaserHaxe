const fs = require('fs');
const srcFolder = "./src/";
const libFolder = srcFolder + "phaserHaxe/";
const haxefiles = [];

function getHaxeFiles(sourcePath)
{
    for (path of fs.readdirSync(sourcePath)) 
    {
        const fullPath = sourcePath + path;
        if (fullPath.endsWith(".hx") && fs.lstatSync(fullPath).isFile())
        {
            haxefiles.push(fullPath);
        }
        else if (fs.lstatSync(fullPath).isDirectory())
        {
            getHaxeFiles(fullPath + "/");
        }
    }
}
getHaxeFiles(libFolder);

const replaceAll = (target, search, replacement) =>
{
    return target.replace(new RegExp(search, 'g'), replacement);
}


for (haxefile of haxefiles)
{
    haxefile = replaceAll(haxefile.substring(srcFolder.length, haxefile.length - 3),"/", ".");
    console.log(haxefile);
}