import numpy as np
import matplotlib.pyplot as plt
meter = 1
millimeter = 10** -3 * meter
nanometer = 10** -9 * meter
#function that defines the 1d slit pattern for a double slit
def double_slit(x,l):
    
    #np.logical_and returns 1.0 if both conditions are true, 0.0 otherwise, very useful
    #, add up each slit in the pattern this way
    res = np.logical_and(-l*0.5 < x , x < -0.4 * l) + np.logical_and(l*0.4 < x , x < 0.5 * l)
    
    return res

def normalize(A):
    return A / np.sqrt(np.sum(np.abs(A)**2))

def normalize_max(A):
    return A / np.max(np.abs(A))

def plot_intensity_1d_line(samples_coordinates, A, name, xunits = "millimeter"):
    
    #units for x axis
    samples_plot_coordinates = samples_coordinates
    if(xunits == "millimeter"):
        samples_plot_coordinates = samples_plot_coordinates/millimeter
    
    #Use a stem plot, since the sample count is low
    plt.plot(samples_plot_coordinates, 1/2 * np.abs(A)**2)

    #plotting format
    plt.title(name + " Intensity Samples")

    plt.ylabel("Intensity (W/m)")

    plt.xlabel("Displacement Along Slits "+ "(" + xunits + ")")

    plt.savefig(name + "_intensity.png",dpi = 400)

def plot_intensity_1d(samples_coordinates, A, name, xunits = "millimeter"):
    
    #units for x axis
    samples_plot_coordinates = samples_coordinates
    if(xunits == "millimeter"):
        samples_plot_coordinates = samples_plot_coordinates/millimeter
    
    #Use a stem plot, since the sample count is low
    plt.stem(samples_plot_coordinates, 1/2 * np.abs(A)**2, markerfmt = 'x', basefmt=" ", label = "sampled points")

    #plotting format
    plt.title(name + " Intensity Samples")

    plt.ylabel("Intensity (W/m)")

    plt.xlabel("Displacement Along Slits "+ "(" + xunits + ")")

    plt.savefig(name + "_intensity.png",dpi = 400)


def plot_phase_1d(sample_coordinates, A, name, xunits = "millimeter"):
    #units for x axis
    samples_plot_coordinates = sample_coordinates
    if(xunits == "millimeter"):
        samples_plot_coordinates = samples_plot_coordinates/millimeter
    
    #Use a stem plot, since the sample count is low
    plt.stem(samples_plot_coordinates, np.angle(A), markerfmt = 'x', basefmt=" ", label = "sampled points")

    #plotting format
    plt.title(name + " Phase Samples")

    plt.ylabel("Phase (rad)")

    plt.xlabel("Displacement Along Slits "+ "(" + xunits + ")")

    plt.savefig(name + "_phase.png",dpi = 400)



def propagate_fraunhofer(coordinates, A, _lambda, L):
    #scale the input coordinates correctly, len(coordinates) is the number of samples N
    propagated_coordinates = coordinates * _lambda * L / (np.max(coordinates)-np.min(coordinates))**2 * len(coordinates)
    #apply the FFT (fast DFT) to the field to find the diffraction pattern
    #np.fft.fftshift swaps around the indices of the returned fft from np.fft.fft, since the
    #returned indices before fftshift are not in the normal convenient order physicists like to deal with
    propagated_amplitude = 1/(1.0j * _lambda * L) * np.exp(1.0j*2*np.pi/_lambda * L) * (np.fft.fftshift((np.fft.fft(np.fft.fftshift(A)))))
    
    #return the calculted propagation
    return propagated_coordinates, propagated_amplitude