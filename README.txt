INDEX
	A. THE WAHT
	B. THE HOW


A. THE WHAT
---------------------

The content of this directory allows to partially reproduce the experiments presented in our icsme14 paper.

A full reproduction package cannot be prepared, due to several reasons, among which:
-- size of the raw data : at least 87 git repositories which sum up to 1.5 GB;
-- undisclosure agreement with the author of the pattern detection algorithm, whose sources/binaries cannot be made available by third parties.

The GitWork toolset works in three phases:
1. It takes a git repository and analyze its structure, collecting any information related to commits, branches, etc.
   This data are organized in a java object called gitMiner, which can be conveniently serialized.
   The files '.gm' in the directory 'dumpFiles' are the serialized dumps of all the repositories we analyzed in our experiments.
2. It computes several metrics on the data collected in a gitMiner. These measurements are stored in an object called 'Features'.
   This object is serialized as well (files '.feat' in the dumpFiles directory).
3. It computes metagraphs on given gitMiners, creating a topologically interesting model of the commit history of the repositories.
   Then it detects all patterns in each metagraphs and perform some measurements and stats on these structures, using the info contained
   in GitMiners, Features and metagraphs.
   At the end, several textual tabular files are produced per each repository, which contain highly redundant experimental data.
   All the data we obtained and used are made available in the directory 'gdata-bak'.

The output files contain hundreds of columns, some of which are identically repeated in various files concerning the same repository.
We give here a brief description of these fields to help the user:

  "mo_num_occur", // number of occurrences of the motif in the metagraph
  "mo_num_nodes", // number of non sequential commits in the motif (structural nodes)
  "mo_num_edges", // number of edges (excluding parallel ones, thus structural edges)
  "mo_z-score",   // z-score that measure the significance of the number of occurrences of the motif in the metagraph (not used)
  "mg_diameter",  // diameter of the metagraph
  "mg_num_edges", // number of metaedges in the metagraph
  "mg_num_nodes", // number of non-sequential nodes in the metagraph (structural nodes)
  "mg_num_commits", // total number of commits in the metagraph (structural nodes + internals)
  "mg_num_authors", // total number of distinct authors of commits in the metagraph (considering structural nodes + internals)
  "mg_mo_edges"   // number of metaedges that are part of a motif (each metaedge is considered only once)
  "mo_min_layer",     // minimum layer of a motif occurrence
  "mo_max_layer",     // maximum layer of a motif occurrence
  "mo_min_timestamp", // minimum timestamp of a motif occurrence
  "mo_max_timestamp", // maximum timestamp of a motif occurrence
  "mo_tot_edges",     // number of edges in a motif (parallel included)
  "mo_num_parallels", // number of groups of parallel edges within a motif occurrence
  "mo_seq_commits",   // number of sequential commits in a motif occurrence
  "mo_me_authors_int",    // number of authors of internal commits per metaedge of a motif (occurrence)
  "mo_me_authors_ext",    // number of authors of structural commits per metaedge of a motif (occurrence)
  "mo_me_authors_both",    // number of authors who appear in intersection between internal and structural commits per metaedge of a motif (occurrence)
  "mo_me_seq_commits", // number of (internal?) commits per metaedge of a motif (occurrence)
  "mo_line_mods", // sum of line changes in a motif (occurrence) (internal commits)
  "mo_file_mods", // sum of file changed (possibly with duplicate entries) in a motif (occurrence) (internal commits)
  "mg_mo-me_authors_int",     // number of authors of internal commits per motif-belonging metaedge in the metagraph (each metaedge is considered only once)
  "mg_mo-me_authors_ext",     // number of authors of structural commits per motif-belonging metaedge in the metagraph (each metaedge is considered only once)
  "mg_mo-me_authors_both",     // number of authors of (internal && structural) commits per motif-belonging metaedge in the metagraph (each metaedge is considered only once)
  "mg_mo-me_seq_commits", // number of internal commits per motif-belonging metaedge in the metagraph (each metaedge is considered only once)
  "mg_non-mo-me_authors_int", // number of authors of internal commits per non-motif-belonging metaedge in the metagraph
  "mg_non-mo-me_authors_ext", // number of authors of structural commits per non-motif-belonging metaedge in the metagraph
  "mg_non-mo-me_authors_both", // number of authors of (internal && structural) commits per non-motif-belonging metaedge in the metagraph
  "mg_non-mo-me_seq_commits", // number of internal commits per non-motif-belonging metaedge in the metagraph
  "mg_me_authors_int",    // number of authors of internal commits per metaedge in the metagraph
  "mg_me_authors_ext",    // number of authors of structural commits per metaedge in the metagraph
  "mg_me_authors_both",    // number of authors of (internal && structural) commits per metaedge in the metagraph
  "mg_seq_commits",   // number of internal commits per metaedge in the metagraph
  "mg_layer_width",   // number of non-sequential commits (structural nodes) in a metagraph layer
  "mg_layer_density", // number of metaedges within two consecutive metagraph layers
  "mg_layer_time",     // duration of the time window of metagraph layers
  "mg_me_line_mods", // sum of line changes in the metaedges (internal commits)
  "mg_me_file_mods", // sum of file changed (possibly with duplicate entries) in the metaedges (internal commits)
  "mg_non-mo-me_line_mods", // sum of line changes in non-motif-belonging metaedges (internal commits)
  "mg_non-mo-me_file_mods", // sum of file changed (possibly with duplicate entries) in non-motif-belonging metaedges (internal commits)
  "mg_mo-me_line_mods", // sum of line changes in motif-belonging metaedges (internal commits)
  "mg_mo-me_file_mods"  // sum of file changed (possibly with duplicate entries) in motif-belonging metaedges (internal commits)

It must benoted that, while the definition of this measures holds in all the output files, the context which it refers to is described by the file name.
E.g.: 'mo_me_authors_int_*' in file 'ace.allmotifs.agg.gdata' gives the number of authors of internal commits per metaedge as an aggregate over all
occurrences of a pattern. The same measure in file 'tri1__A-T__ace.gdata' is related to each single occurrence (one per line) of this pattern.



B. THE HOW
---------------------

In order to run the version of GitWorks provided yuo must:
-- use a unix/linux 64 bit platform 
-- use a JRE 7
-- use the bash shell

By running the script 'gitWorks.sh' (no argument is needed) an execution is performed on the git repository of the 'ace' project,
which is included here (in the directory STORAGE).
In this execution all the aforementioned three phases are performed, with the only exception of the pattern detection,
for which we use the data we already computed on this repository (see the directory 'polygs').
Once the execution is finished, the results can be found in a directory called 'gdata'.

It is possible to perform phase 3 on all the repository we onsidered in our experiments. We provide in 'dumpFiles' and 'polygs'
all the pre-computed data that can be used to obtained all the results we presented in our paper. They will be collected in 'gdata'
and match those stored in 'gdata-bak'.
To perform such a task, it is necessary to modify one line of the 'gitWorks.sh' script:
the variable 'pRoot' declared in this script, which by default is set ='ajaxorg/ace', must instead be left empty.
Thus, from 'pRoot=ajaxorg/ace' to 'pRoot= #ajaxorg/ace' or equivalent.



