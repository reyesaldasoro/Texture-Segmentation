# Texture-Segmentation
Volumetric Texture Segmentation by Discriminant Feature Selection and Multiresolution Classification


<h1>
Volumetric Texture Segmentation by Discriminant Feature Selection and Multiresolution Classification. <br>
</h1><br>

<h2>Constantino Carlos Reyes-Aldasoro<br>
Abhir Bhalerao</h2>

<p>
    Test data, Matlab code and data sets and user manuals
    
</p>

<br />
<h3>
    
<b>Reyes-Aldasoro,
C.C.</b>, and A. Bhalerao, <span style="font-style: italic;">Volumetric
Texture Segmentation by
Discriminant Feature Selection and Multiresolution Classification,</span>
<a
href="http://ieeexplore.ieee.org/document/4039538/">
IEEE Trans. on Medical Imaging</a> (2007) Vol. 25, No. 1, pp.
1-14.<br />
<b>Reyes-Aldasoro, C.C.</b>, and A.
Bhalerao, <span style="font-style: italic;">The Bhattacharyya space for
feature selection and its
application to texture segmentation</span>, <a
href="http://dx.doi.org/10.1016/j.patcog.2005.12.003">Pattern
Recognition</a>, (2006) Vol. 39, Issue 5, May 2006, pp. 812-826.    
</h3>

<h2>Abstract</h2>
Texture analysis in 2D has been well studied, but many 3D applications
in
Medical Imaging, Stratigraphy or Crystallography, would beneit from 3D
analysis instead of the traditional, slice-by-slice approach. In this
paper a Multiresolution Volumetric Texture Segmentation (M-VTS)
algorithm is presented. The method extracts textural measurements from
the Fourier domain of the data via subband filtering using an
Orientation Pyramid [1]. A novel Bhattacharyya space, based on the
Bhattacharyya distance is proposed for selecting the most discriminant
measurements and producing a compact feature space. Each dimension of
the feature space is used to form the lowest level of a Quad Tree. At
the highest level of the tree, new positional features are added to
improve the contiguity of the classification. The classified space is
then projected to lower levels of the tree where a boundary refinement
procedure is performed with a 3D equivalent of butterfly filters. The
performance of M-VTS is tested in 2D by classifying a set of standard
texture images. M-VTS yields lower misclassification rates than reported
elsewhere [2], [3], [4]. The algorithm was tested in 3D with artificial
isotropic data and three Magnetic Resonance Imaging sets of human knees
with encouraging results. The regions segmented from the knees
correspond to anatomical structures that could be used as a starting
point for other measurements. By way of example, we demonstrate
successful cartilage extraction. <br>
<p> <span
 style="font-size: 9.9pt; font-weight: bold; color: rgb(0, 0, 0);">Keywords</span><span
 style="font-size: 9.9pt; color: rgb(0, 0, 0);">: Volumetric texture,
Filtering, Multiresolution, Texture Segmentation, Feature Selection</span>
</p>

<p> IMPORTANT </p>
<p> Many of these routines were developed some time ago, that is many versions of Matlab have gone through. Some m-files were not 
    available from Matlab at that time (like mode) and thus I created my own. Be careful as some routines may not be compatible with
    the most recent versions of Matlab.
</p>

<hr width="100%"> <br>
<h2>Data and programs: everything is in <a href="http://www.mathworks.com">matlab</a>  format.
</h2>

<br>
<div align="center"><br>
Data<br>
<br>
</div>
<table align="center" border="1" cellpadding="2" cellspacing="2"
 width="80%">
<tbody>
<tr>
<td><i>File<br>
</i> </td>
<td valign="top"><i>Description<br>
</i> </td>
<td valign="top"><i>Image <br>
</i> </td>
</tr>
<tr>
<td valign="top" width="20%">orient3dcube<br>
</td>
<td valign="top">Two oriented patterns of 64 x 32 x 64 elements
each, with different frequency and orientation. The file contains two
matrices:<br>
data  -  64x64x64 original data,  Features can be
extracted
from here, and<br>
dataFeats - two filtered features <br>
</td>
<td valign="top" width="20%">
      
![Screenshot](orientPatt3D.gif)
<br>
</td>
</tr>

<tr>
<td valign="top" width="20%">gauss3dcube<br>
</td>
<td valign="top">Two bi-variate Gaussian distributions of size 32
x 32 x 32 pixels with similar means and variances, each with dimensions
32 x 16x 32. This are considered as features for the classification
process.<br>
<br>
A mask for this data can be created by:<br>
mask=ones(32,32,32);<br>
mask(:,1:16,:)=2;<br>
</td>
<td valign="top" width="20%">

![Screenshot](gauss3D.gif)
<br>
</td>
</tr>
<tr>
<td valign="top" width="20%">figure11f<br>
</td>
<td valign="top">Just one of the figures with different textures,
the whole set, with training data if needed is available at Trygve
Randen's webpage:<br>
<br>
<a href="http://www.ux.uis.no/%7Etranden/">http://www.ux.uis.no/~tranden/</a><br>
</td>
<td valign="top" width="20%">

![Screenshot](fig11f.gif)
<br>
</td>
</tr>
<tr>
<td valign="top">mask<br>
</td>
<td valign="top">16 class mask for the figure above<br>
</td>
<td valign="top">

![Screenshot](mask.gif)<br>
</td>
</tr>
<tr>
<td valign="top">
       Phantom<br>
       Phantom Mask<br>

</td>
<td valign="top">A 64 x 64 x 64 phantom of artificial textures<br>
</td>
<td valign="top">

![Screenshot](phantom.jpg)
<br>
</td>
</tr>
</tbody>
</table>


<br>
<div align="center"><br>
Main Programs<br>
<br>
</div>
<table align="center" border="1" cellpadding="2" cellspacing="2"
 width="80%">
<tbody>
<tr>
<td valign="top"><i>File<br>
</i> </td>
<td valign="top"><i>Description<br>
</i> </td>
</tr>
<tr>
<td valign="top" width="20%">mVts</a><br>
</td>
<td valign="top"> Multi-resolution Volumetric Texture
Segmentation main program<br>
This program Classifies in a hierarchical methodology that climbs 
over a Quad Tree up to a desired level (levsP), classifies with
extra positional features, and then propagates downwards with the 
boundaries filtered with Pyramidal butterfly filters <br>

</td>
</tr>
<tr>
<td valign="top" width="20%">sopy</a><br>
</td>
<td valign="top">sopy transforms data into the Fourier Domain and
then 
filters it with a Second Orientation Pyramid tessellation 
with truncated Gaussians in different frequency-orientation positions
<br>
</td>
</tr>
<tr>
<td valign="top" width="20%">sopy3d</a><br>
</td>
<td valign="top">3D version of the above<br>
</td>
</tr>
<tr>
<td valign="top" width="20%">kmeans_b</a><br>
</td>
<td valign="top">k-means classifier<br>
</td>
</tr>
</tbody>
</table>





<div align="center"><br>
Other Programs <br>
(subroutines)<br>
<br>
<table align="center" border="1" cellpadding="2" cellspacing="2"
 width="80%">
<tbody>
<tr>
<td valign="top"><i>File<br>
</i> </td>
<td valign="top"><i>Description<br>
</i> </td>
</tr>
<tr>
<td valign="top" width="20%">arrangeData</a><br>
</td>
<td valign="top">Rearrangement of data from several formats to 2D
[RCL x numFeats]<br>
RCL=number of Rows * number of
Columns * number of Levels<br>
numFeats= number of features <br>
</td>
</tr>

<tr>
<td valign="top" width="20%">bhattaM</a><br>
</td>
<td valign="top">Bhattacharyya Measurement Calculation<br>
</td>
</tr>


<tr>
<td valign="top" width="20%">expandu</a><br>
</td>
<td valign="top">Quad Tree expansion<br>
</td>
</tr>
<tr>
<td valign="top" width="20%">gaussF</a><br>
</td>
<td valign="top">GAUSSF produces an N-dimensional gaussian
function (N=1,2,3)<br>
</td>
</tr>
<tr>
 <td>ndgauss_r.m</a> </td>
 <td>A Gaussian function for the filters </td>
</tr>
<tr>
<td>cTessel.m</a></td>
<td>Provides central Tesselation</td>
</tr>
<tr>
<td>qTessel.m</a></td>
<td>Provides Quadrant Tesselation</td>
</tr>

<tr>
<td>cDeTessel.m</a></td>
<td>Provides central De- Tesselation</td>
</tr>

<tr>
<td>qDeTessel.m</a></td>
<td>Provides Quadrant De- Tesselation</td>
</tr>


<tr>
<td valign="top" width="20%">im2colRed</a><br>
</td>
<td valign="top">Rearrange image blocks into columns with only
some of the pixels<br>
</td>
</tr>
<tr>
<td valign="top">LBG.m</a><br>
</td>
<td valign="top">Linde Buzo Gray vector quantising algorithm <br>
</td>
</tr>
<tr>
<td valign="top">minDist</a><br>
</td>
<td valign="top">determines minimum distance and assign to a
class<br>
</td>
</tr>
<tr>
<td valign="top">normData</a><br>
</td>
<td valign="top">normalises data by dividing over the std <br>
</td>
</tr>
<tr>
<td valign="top">normProb</a><br>
</td>
<td valign="top">Normal Probability calculation<br>
</td>
</tr>
<tr>
<td valign="top">padData</a><br>
</td>
<td valign="top">Padds data with the same values on the edges<br>
</td>
</tr>
<tr>
<td valign="top">pixvsn</a><br>
</td>
<td valign="top">compares value of pixel versus neighbours and
change if necessary<br>
</td>
</tr>
<tr>
<td valign="top">reduceu</a><br>
</td>
<td valign="top">Quad Tree reduction<br>
</td>
</tr>
<tr>
<td valign="top">surfdat</a><br>
</td>
<td valign="top">Plots in several dimensions<br>
</td>
</tr>
<tr>
<td valign="top">surfSOP</a><br>
</td>
<td valign="top">Display 2 levels of the SOP results<br>
</td>
</tr>
<tr>
<td valign="top">vol2col</a><br>
</td>
<td valign="top">Rearrange volume blocks into columns in a
sliding fashion<br>
</td>
</tr>
<tr>
<td valign="top">mode</a><br>
</td>
<td valign="top">Mode<br>
</td>
</tr>
<tr>
<td valign="top">setImod</a><br>
</td>
<td valign="top">subroutine for reduceu and expandu<br>
</td>
</tr>
<tr>
<td valign="top">prod3d</a><br>
</td>
<td valign="top">3D products<br>
</td>
</tr>
<tr>
<td valign="top">createButter</a><br>
</td>
<td valign="top">Creates the butterfly filters<br>
</td>
</tr>

<tr>
<td valign="top">unSupMask</a><br>
</td>
<td valign="top">for Unsupervised cases<br>
</td>
</tr>
<tr>
<td valign="top">hist2d</a><br>
</td>
<td valign="top">histogram of 2D signals <br>
</td>
</tr>
</tbody>
</table>

<h2>A Graphic Example of Subband filtering</h2>

 <br>
 
![Screenshot](MVTS_IPtr_img_2.jpg)
<br>
<br>
<br>
<h2>Results</h2>
<br>
<br>
<div align="center">

![Screenshot](res1.gif)
 <br>
</div>
<br>
<br>
<br>
<table align="center" border="1" cellpadding="2" cellspacing="2"
 width="80%">
<tbody>
<tr>
<td valign="top" width="50%"> Original Images (from Randen)<br>
<a href="http://www.ux.uis.no/%7Etranden/">http://www.ux.uis.no/~tranden/</a>

![Screenshot](res2.gif)
  <br>
</td>
<td valign="top" width="50%"> Classification with M-VTS<br>

![Screenshot](res3.jpg)
  <br>
</td>
</tr>
<tr>
<td valign="top" width="50%">Boundaries imposed in the original
images<br>
<br>

![Screenshot](res4.jpg)
  <br>
</td>
<td valign="top" width="50%">Correctly classified pixels in white<br>
<br>

![Screenshot](res5.jpg)
  <br>
</td>
</tr>
</tbody>
</table>
<br>

<div align="center"> <br>
 
<table border="1" cellpadding="2" cellspacing="2" width="80%">
<tbody>
<tr>
<td valign="top">

![Screenshot](res6.gif)
 <br>
</td>
</tr>
<tr>
<td valign="top">

![Screenshot](res7.gif)
 <br>
</td>
</tr>
<tr>
<td valign="top"> 

![Screenshot](res8.gif)
 <br>
</td>
</tr>
</tbody>
</table>
<br>
<br>
</div>
<br>
<br>

![Screenshot](MVTS_IPtr_img_30.jpg)
 <br>
<br>

![Screenshot](MVTS_IPtr_img_31.jpg)
<br>
<br>
<br>


