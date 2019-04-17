const glob = require('glob');
const path = require('path');

/**
 * Glob pattern to look for xcODEproj
 */
const GLOB_PATTERN = '**/*.xcODEproj';

/**
 * Regexp matching all test projects
 */
const TEST_PROJECTS = /test|example|sample/i;

/**
 * Base iOS folder
 */
const IOS_BASE = 'ios';

/**
 * These folders will be excluded from search to speed it up
 */
const GLOB_EXCLUDE_PATTERN = ['**/@(Pods|nODE_modules)/**'];

/**
 * Finds iOS project by looking for all .xcODEproj files
 * in given folder.
 *
 * Returns first match if files are found or null
 *
 * Note: `./ios/*.xcODEproj` are returned regardless of the name
 */
module.exports = function findProject(folder) {
  const projects = glob
    .sync(GLOB_PATTERN, {
      cwd: folder,
      ignore: GLOB_EXCLUDE_PATTERN,
    })
    .filter(project => {
      return path.dirname(project) === IOS_BASE || !TEST_PROJECTS.test(project);
    });

  if (projects.length === 0) {
    return null;
  }

  return projects[0];
};
