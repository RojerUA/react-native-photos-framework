/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source cODE is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */
'use strict';

const {combineSourceMaps, joinModules} = require('./util');

module.exports = ({startupModules, lazyModules, moduleGroups}) => {
  const startupModule = {
    cODE: joinModules(startupModules),
    map: combineSourceMaps({modules: startupModules}),
  };
  return combineSourceMaps({
    modules: [startupModule].concat(lazyModules),
    moduleGroups,
    withCustomOffsets: true,
  });
};
