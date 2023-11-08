# Noise removal techniques in ECG Signals
## Using EMD Models 
**1. Input:**
Begin with the noisy ECG signal as the input, which contains the desired cardiac information along with unwanted noise.

**2. Sifting Process:**
1. Identify Extrema (Maxima and Minima): Locate the peaks (maxima) and troughs
(minima) in the noisy ECG signal. These points are vital for understanding the underlying
oscillatory behavior of the signal.
2. Interpolate Upper and Lower Envelopes: Use cubic spline interpolation to create
smooth curves that join the identified maxima and minima, forming upper and lower
envelopes. These envelopes help define the dominant oscillatory patterns in the signal.
3. Calculate the Mean Envelope: Compute the mean of the upper and lower envelopes
to represent the central tendency of the oscillations in the signal.
4. Extract the IMF (Intrinsic Mode Function): Subtract the mean envelope from the noisy
ECG signal. This process helps to isolate one of the intrinsic oscillatory components of
the signal, known as the IMF.
5. Update the Residue Signal: Modify the noisy ECG signal by subtracting the extracted
IMF. This updated signal (residue) now contains the remaining components and noise.

**3. Termination Criterion:**
Check if the residue signal is either a constant or exhibits a monotonic slope, or if it is
a function with only one extremum. If this condition is met, the algorithm terminates,
indicating that further extraction of IMFs is not necessary.

**4.Reconstruction:**
Reconstruct the denoised ECG signal by adding together all the extracted IMFs. This
results in a denoised signal that has been cleaned of unwanted noise.

## Wavelet denoising 
Wavelet denoising is a signal processing technique used to remove unwanted noise from signals, particularly in applications like ECG (Electrocardiogram) signal processing. Here's an explanation of the wavelet denoising method:

**1. Wavelet Transform:**
   - The process begins with the application of the wavelet transform to the noisy ECG signal. The wavelet transform decomposes the signal into various frequency components, each representing different scales. This allows for the separation of noise from the essential ECG features.

**2. Thresholding:**
   - After the wavelet transformation, a thresholding step is applied to the wavelet coefficients obtained at different scales.
   - Thresholding methods, such as soft or hard thresholding, are used to retain significant coefficients while reducing or eliminating those associated with noise.
   - Thresholding operates by comparing the magnitude of each coefficient to a predefined threshold value.

**3. Soft Thresholding:**
   - In soft thresholding, coefficients below the threshold are set to zero, effectively eliminating noise components.
   - Coefficients above the threshold are retained, preserving significant signal components.

**4. Hard Thresholding:**
   - In hard thresholding, coefficients below the threshold are set to zero, just like in soft thresholding.
   - However, hard thresholding goes further by also eliminating coefficients above the threshold, which can be useful for aggressive noise reduction.

**5. Choosing the Threshold Value:**
   - Selecting the appropriate threshold value is a crucial step. The choice of the threshold value depends on the characteristics of the ECG signal and the nature of the noise.
   - Optimizing the threshold value can significantly impact the denoising performance.

**6. Reconstruction:**
   - Once the noisy wavelet coefficients have been thresholded, the inverse wavelet transform is applied to reconstruct the denoised ECG signal.
   - This reconstructed signal should ideally retain the essential features of the original ECG while removing or significantly reducing noise components.

**7. Evaluation:**
   - The denoised ECG signal is then evaluated to ensure that important features have been preserved, and noise has been effectively reduced.

**8. Iteration (if needed):**
   - In some cases, the denoising process may be performed iteratively to further refine the result.

In summary, wavelet denoising is a method for removing noise from signals like ECG by using the wavelet transform to decompose the signal into different frequency components and applying thresholding to selectively remove unwanted noise. The choice of the threshold value is critical for effective denoising. The final result is a cleaner signal with preserved essential information. Wavelet denoising is widely used in various applications to enhance signal quality and improve analysis accuracy.

## Hybrid Model 

**R-peak detection algorithm :** 

Here we have used the Pan-Tompkins QRS detection
algorithm. This is applied to the reconstructed ECG signal to detect the R-peaks. These
R-peaks are then added back to the denoised signals to ensure no loss of information
before applying the ASMF filter.
Pan-Tompkin’s algorithm utilises the amplitude, slope and width of an integrated window. The algorithm consists of two stages pre-processing and decision. In first stage the
noise removal, signal smoothing, and width and QRS slope increasing is done. Then the
thresholds are used to only consider the signal peaks and eliminate the noise peaks in the
nest stage. The steps include:

1. Bandpass filtering: This reduces the influence of noise while preserving the QRS complex. The ECG signal is passed through a bandpass filter to isolate frequency range of
interest.

2. Differentiation: After filtering, the signal is differentiated and low frequency P and T
waves are suppressed in the derivative process to get high frequency signals in the complex.

3. Squaring: The obtained signal is squared to get sharp, and all positive value. Higher
amplitudes are further enhanced while attenuating other parts of the signal. Moving window integration (MWI): also known as the moving average is applied in order to smoothen
the signal and emphasise on the overall energy of the QRS complex.

4. Decision: This is performed to decide whether or not the result of MWI is a QRS
complex with the help of thresholds. An adaptive threshold is calculated based on mean
and SD of the integral signal to determine the match with QRS complex. The peaks that
surpass the adaptive threshold is considered as potential R-peaks. However necessary
steps are taken to avoid the detection of noise and T waves as R peaks.

**Adaptive switching mean filter (ASMF) Algorithm:**
1) A particular length of window is taken, and at each iteration, the centre of the window
is placed on a test ECG sample.
2) A threshold value is estimated by calculating the standard deviation of the windowed
region.
3) If the difference between test ECG sample and the mean value of the windowed area
is beyond the threshold limit, then it is considered as a corrupted sample, and its value
is updated according to the mean value.
