%% This script starts Automagic

if ispc
    slash = '\';
    seperator = ';';
else
    slash = '/';
    seperator = ':';
end
automagic = 'automagic'; % Folder name of automagic
libName = 'matlab_scripts'; 
srcFolder = 'src'; 
guiFolder = 'gui';
preproFolder = 'preprocessing';
mainGuiFile = 'mainGUI.m';

addpath('./')
matlabPaths = matlabpath;
parts = strsplit(matlabPaths, seperator);
Index = not(~contains(parts, automagic));
automagicPath = parts{Index};
automagicPath = strcat(automagicPath, '/');
automagicPath = regexp(automagicPath, ['.*' automagic '.*?/'], 'match');
automagicPath = automagicPath{1};
automagicPath = [automagicPath slash];
addpath(automagicPath);
addpath([automagicPath srcFolder slash])
addpath([automagicPath guiFolder slash])
addpath([automagicPath preproFolder slash])
addpath([automagicPath libName slash])

run([guiFolder slash mainGuiFile])

