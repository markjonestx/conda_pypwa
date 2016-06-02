# Anaconda PyPWA Install Scripts.
This repository exists to hold all the build scripts along with a little
documentation so that users and developers alike can install their PyPWA or
any of the dependencies in for PyPWA with ease.

## Current Conda Install Scripts
Indentions are based on which packages are needed by which packages. For example
if you only want to install PyMultiNest, the packages you would need to install
are Cuba and MultiNest.

PyPWA
 * appdirs
 * iminuit
 * PyMultiNest
   * Cuba
   * MultiNest
 * pytest-cov
 * pytest-runner
   * hgtools
 * tabulate

## Notes:
1. If you are installing the software across multiple systems, compile the
	software on the oldest system first so that any libraries that are linked
	at compile time you know will work will all systems. It may result in
	slower execution, but at least you know it will run across all of your 
	supported systems.
2. Conda doesn't have great documentation when it comes to shared object
	libraries, however conda does do a good job of filling the values you need
	in order for the libraries to compile correctly, you just need to make sure
	you have the proper libraries set to for build and install in the meta.yaml
	file followed by setting your prefixes correctly.
3. If your library uses cmake, use Condas cmake not your distros, it will
	reduce the chance of error without adding any complexity.
4. If your project uses blas, atlas, or lapack, consider using conda's mkl, its
	a math kernel library forked and optimized by Intel, and is the only place
	where you can get lapack from in anaconda without installing it yourself or
	using another users. 