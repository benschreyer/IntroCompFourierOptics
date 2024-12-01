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

def lens(coordinates, f, _lambda):
    #sum of x,y coordinates squared give the squared distance from the 0 coordinate
    r_sq_field = (coordinates[:,:,0]**2  + coordinates[:,:,1]**2)
    
    #lens phase angle field
    phi = np.pi * r_sq_field/_lambda/f
    
    return np.exp(1.0j * phi)

#A gaussian utility function
def gaussian(x, sigma):
    return np.exp(-((x/sigma)**2))

def boxcar(x, w):
    return np.logical_and((x) > -w/2, (x) < w/2)

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

def plot_real_1d_line(samples_coordinates, A, name, xunits = "millimeter"):
    
    #units for x axis
    samples_plot_coordinates = samples_coordinates
    if(xunits == "millimeter"):
        samples_plot_coordinates = samples_plot_coordinates/millimeter
    
    plt.plot(samples_plot_coordinates, np.real(A))

    #plotting format
    plt.title(name + " Real Part")

    plt.ylabel("Re(A)")

    plt.xlabel("Displacement Along Slits "+ "(" + xunits + ")")

    plt.savefig(name + "_real.png",dpi = 400)


def plot_imag_1d_line(samples_coordinates, A, name, xunits = "millimeter"):
    
    #units for x axis
    samples_plot_coordinates = samples_coordinates
    if(xunits == "millimeter"):
        samples_plot_coordinates = samples_plot_coordinates/millimeter
    

    plt.plot(samples_plot_coordinates, np.imag(A))

    #plotting format
    plt.title(name + " Imag. Part")

    plt.ylabel("Im(A)")

    plt.xlabel("Displacement Along Slits "+ "(" + xunits + ")")

    plt.savefig(name + "_imag.png",dpi = 400)


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

#A new propagation, the only change relative to the Fraunhofer propagation is the quadratic phases
def propagate_fresnel(coordinates, A, _lambda, L):
    #scale the input coordinates correctly, len(coordinates) is the number of samples N
    propagated_coordinates = coordinates * _lambda * L / (np.max(coordinates)-np.min(coordinates))**2 * len(coordinates)
    #apply the FFT (fast DFT) to the field to find the diffraction pattern
    #np.fft.fftshift swaps around the indices of the returned fft from np.fft.fft, since the
    #returned indices before fftshift are not in the normal convenient order physicists like to deal with
    
    #Fresnel quadratic phase factors
    B_fp = np.exp(1.0j * np.pi / _lambda / L * (propagated_coordinates)**2)
    B_f = np.exp(1.0j * np.pi / _lambda / L * (coordinates)**2)

    propagated_amplitude = B_fp * 1/(1.0j * _lambda * L) * np.exp(1.0j*2*np.pi/_lambda * L) * (np.fft.fftshift((np.fft.fft(np.fft.fftshift(A * B_f)))))
    
    #return the calculted propagation
    return propagated_coordinates, propagated_amplitude

#2d sampling

def generate_2d_coordinates(grid_size,grid_dimension):
    
    #Build an array of appropriate size, square of grid points, each point has 2 values, its x coordinate, and y coordinate
    coordinate_array =   grid_dimension / grid_size * np.mgrid[- grid_size // 2: grid_size // 2,- grid_size // 2: grid_size // 2]
        
    #Return the grid, place the non spatial index last, this is generally advised, helps with array manipulations
    # but is not necessary
    return np.swapaxes(coordinate_array,0,2)


#return the phase change as a phasor array for a tilted mirror
def small_angle_mirror_phase(coordinates, photon_lambda, angle, axis = "y"):
    if angle > 0.2:
        print("Not a small angle mirror")
    if axis == "y":
        return np.exp(1.0j * 2 * np.pi * 2 * angle * coordinates[:,:,0] / photon_lambda)
    else:
        return np.exp(1.0j * 2 * np.pi * 2 * angle * coordinates[:,:,1] / photon_lambda)
#Returns a unity magnitude complex field encoding the phase due to a mirror tilt.

#2d Fresnel single Fourier transform

def propagate_fresnel_2d(coordinates, A, _lambda, L):
    #scale the input coordinates correctly, len(coordinates) is the number of samples N
    propagated_coordinates = coordinates * _lambda * L / (np.max(coordinates)-np.min(coordinates))**2 * len(coordinates)
    #apply the FFT (fast DFT) to the field to find the diffraction pattern
    #np.fft.fftshift swaps around the indices of the returned fft from np.fft.fft, since the
    #returned indices before fftshift are not in the normal convenient order physicists like to deal with
    
    #Fresnel quadratic phase factors
    B_fp = np.exp(1.0j * np.pi / _lambda / L * np.sum(propagated_coordinates**2,axis = 2))

    B_f = np.exp(1.0j * np.pi / _lambda / L * np.sum((coordinates)**2, axis = 2))

    propagated_amplitude = B_fp * 1/(1.0j * _lambda * L) * np.exp(1.0j*2*np.pi/_lambda * L) * (np.fft.fftshift((np.fft.fft2(np.fft.fftshift(A * B_f)))))
    
    #return the calculted propagation
    return propagated_coordinates, propagated_amplitude

#Plotting utility for 2d wave amplitudes

def plot_2d_intensity(coordinates, amplitude, name = ""):
    #mirror the plotted amplitude about the x axis, since image arrays are stored opposite of physics convention
    amplitude_plot = np.flip(amplitude, 0) 
    plt.title(name + " 2d Intensity")
    
    #The intensity is maximum normalized, and the coordinate grid is assumed to be square
    #Use the extent =[...] parameter to change the axes to having units of length, rather than index
    plt.imshow(np.square(np.abs(normalize_max(amplitude_plot))), extent = [np.min(coordinates/ millimeter), np.max(coordinates / millimeter)] * 2)
    plt.xlabel("x (mm)")
    plt.ylabel("y (mm)")
    plt.colorbar()
    plt.savefig(name + "_intensity.png",dpi = 400)


def plot_2d_phase(coordinates, amplitude, name = ""):
    #mirror the plotted amplitude about the x axis, since image arrays are stored opposite of physics convention
    amplitude_plot = np.flip(amplitude, 0) 
    plt.title(name + " 2d Phase")
    
    #The intensity is maximum normalized, and the coordinate grid is assumed to be square
    #Use the extent =[...] parameter to change the axes to having units of length, rather than index
    
    #Use a cyclic colormap 'twilight'
    #And disable interpolation to remove phase display artifacts
    #np.angle gives phase as -pi to pi, to get 0 to 2pi, just add a constant phase pi
    plt.imshow(np.angle(amplitude_plot) + np.pi, extent = [np.min(coordinates/ millimeter), np.max(coordinates / millimeter)] * 2, cmap = "twilight", vmin = 0.0, vmax = 2 * np.pi, interpolation = "none")
    plt.xlabel("x (mm)")
    plt.ylabel("y (mm)")
    plt.colorbar()
    plt.savefig(name + "_phase.png",dpi = 400)

def normalize(A):
    return A / np.sqrt(np.sum(np.abs(np.square(A))))

def centroid(coordinates, amplitude):
    
    #Make the sum of the square amplitudes 1, so that calculating the centroid calculation doesnt
    #explicitly require normalization
    amplitude_normalized = normalize(amplitude)
    
    #Coordinates is a 2d array with shape (N,N,2) the last index is for the x or y sample coordinate
    
    #Calculate the expected value for x by summing all sample x coordinates weighted with their normalized intensity
    #Ex = #sum(#Fill in * np.abs(np.square(amplitude_normalized)))

    #Calculate the expected value for y by summing all sample y coordinates weighted with their normalized intensity
    #Ey = #sum(#Fill in * np.abs(np.square(amplitude_normalized)))
    
    #Calculate the expected value for x by summing all sample x coordinates weighted with their normalized intensity
    Ex = np.sum(coordinates[:,:,0] * np.abs(np.square(amplitude_normalized)))

    #Calculate the expected value for y by summing all sample y coordinates weighted with their normalized intensity
    Ey = np.sum(coordinates[:,:,1]* np.abs(np.square(amplitude_normalized)))

    #return the centroid
    return Ex,Ey            

def beam_parameters_2d(coordinates, A):

    An = normalize(A)

    #Calculate the expected values for x**2 and x
    #Normalization is already done so no denominator needed

    #Expected value for x^2
    Ex2 = np.sum(coordinates[:,:,0]**2 *np.abs( np.square(An)))

    #Expected value for x, the centroid in x direction
    Ex = np.sum(coordinates[:,:,0] * np.abs( np.square(An)))

    #Calculate the expected values for y**2 and y   
    Ey2 = np.sum(coordinates[:,:,1]**2 *np.abs( np.square(An)))
    Ey = np.sum(coordinates[:,:,1] * np.abs( np.square(An)))

    #Use the variance based width (standard deviation) to report a width, and return the centroid
    return np.sqrt(Ex2 - Ex**2), np.sqrt(Ey2 - Ey**2),Ex,Ey            
