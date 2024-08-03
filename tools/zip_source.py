import os
from zipfile import ZipFile, ZIP_LZMA

def createReleasePath():
  dirName = '../x/armadatabaseframework/release'

  if not os.path.exists(dirName):
    os.makedirs(dirName)
    print('Directory ', dirName, ' created.')
  else:
    print('Directory ', dirName, ' already exists!')

def getAllFilePaths(dirName):
  filePaths = []
  for root, directories, files in os.walk(dirName):
    for fileName in files:
      filePath = os.path.join(root, fileName)
      filePaths.append(filePath)
  return filePaths

def main():
  dirName = '../armadatabaseframework'
  filePaths = getAllFilePaths(dirName)
  print('The following files will be zipped:')
  for fileName in filePaths:
    print(fileName)
  with ZipFile('../x/armadatabaseframework/release/armadatabaseframework.zip', 'w', compression=ZIP_LZMA) as zip:
    for file in filePaths:
      zip.write(file)
  print('All files zipped successfully!')

if __name__ == "__main__":
  createReleasePath()
  main()