const PbxFile = require('xcODE/lib/pbxFile');
const removeFromPbxReferenceProxySection = require('./removeFromPbxReferenceProxySection');

/**
 * Removes file from static libraries
 *
 * Similar to `nODE-xcODE` addStaticLibrary
 */
module.exports = function removeFromStaticLibraries(project, path, opts) {
  const file = new PbxFile(path);

  file.target = opts ? opts.target : undefined;

  project.removeFromPbxFileReferenceSection(file);
  project.removeFromPbxBuildFileSection(file);
  project.removeFromPbxFrameworksBuildPhase(file);
  project.removeFromLibrarySearchPaths(file);
  removeFromPbxReferenceProxySection(project, file);

  return file;
};
