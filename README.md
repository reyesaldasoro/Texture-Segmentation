# Texture-Segmentation

<h1>
Texture segmentation: an objective comparison between traditional and deep-learning methodologies <br>
</h1><br>



<p>
    Test data, Matlab code and data sets and user manuals

</p>

<br />
<h3>
    This paper has been published in Applied Sciences <a href="https://www.mdpi.com/2076-3417/9/18/3900">https://www.mdpi.com/2076-3417/9/18/3900</a>. If you find it useful, please cite accordingly.
</h3>

<h2>Abstract</h2>
This paper compares a series of traditional and deep learning methodologies for the segmentation of textures. Six well-known texture composites first published by Randen and Husoy were used to compare traditional segmentation techniques (co-occurrence, filtering, local binary patterns, watershed, multiresolution sub-band filtering) against a deep-learning approach based on the U-Net architecture. For the latter, the effects of depth of the network, number of epochs and different optimisation algorithms were investigated. Overall, the best results were provided by the deep-learning approach. However, the best results were distributed within the parameters, and many configurations provided results well below the traditional techniques.
</p>

<p> IMPORTANT </p>
<p>
</p>

<hr width="100%"> <br>
<h2>Data and programs: everything is in <a href="http://www.mathworks.com">matlab</a>  format.
</h2>


<h2>Short Tutorial</h2>



Clear all the data and close all windows

``` {.codeinput}
  clear all
  close all
```
Load the matrix with the data from Randen's paper
``` {.codeinput}
  load randenData
  whos
```

<pre class="codeoutput">  Name             Size               Bytes  Class    Attributes

  dataRanden       1x9              9438192  cell               
  maskRanden       1x9              9438192  cell               
  trainRanden      1x9             40371184  cell               

</pre>

<h2 id="3">display the first composite image with five textures</h2>
<pre class="codeinput">imagesc(dataRanden{1})
colormap <span class="string">gray</span>
</pre>
<img vspace="5" hspace="5" src="Figures\readme_01.png" alt="">


This is just one of the figures with different textures, the whole set, with training data (not Matlab)
if needed is available at Trygve
Randen's webpage:
<br>
<a href="http://www.ux.uis.no/%7Etranden/">http://www.ux.uis.no/~tranden/</a><br>



 <h2 id="4">display the corresponding mask</h2>
 <pre class="codeinput">imagesc(maskRanden{1})
colormap <span class="string">jet</span>
</pre>
<img vspace="5" hspace="5" src="Figures\readme_02.png" alt="">
 <h2 id="5">display a montage with the training data</h2>
 <pre class="codeinput">montage(mat2gray( trainRanden{1}))
</pre>

<img vspace="5" hspace="5" src="Figures\readme_03.png" alt="">

<br>

<p> To generate training data that will be used to train U-Nets in 32x32 patches you can use either of the following files:

``` {.codeinput}
prepareTrainingLabelsRanden.m
```

``` {.codeinput}
prepareTrainingLabelsRanden_HorVerDiag.m
```
The first one will only prepare patches with two vertical textures, whilst the second will arrange in diagonal, vertical and horizontal arrangements. Obviously, you will need to change the lines where folders are defined so that you save these training pairs of textures and labels correctly in your computer. The patches look like this:

<img vspace="5" hspace="5" src="Figures\Fig5.png" alt="">

Finally, to train and compare results you need to run the file:

``` {.codeinput}
segmentationTextureUnet.m
```

This file will loop over different training options and network configurations, so it takes long, very long especially if you do not have GPUs enabled.

Current results are shown below.

<img vspace="5" hspace="5" src="Figures\Fig6D.png" alt="">


More details are described in the paper.
