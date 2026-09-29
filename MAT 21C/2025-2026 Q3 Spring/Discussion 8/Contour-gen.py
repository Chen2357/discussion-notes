import numpy as np
import matplotlib.pyplot as plt
import csv
from matplotlib.path import Path

def export_contours_to_csv(func, box, config, filename="contours.csv"):
    """
    Evaluates a 2D function and outputs its contour lines to a CSV.
    Each row in the CSV represents a single, strictly connected contour line segment.
    """
    xmin, xmax, ymin, ymax = box
    nx = config.get('nx', 200)          
    ny = config.get('ny', 200)          
    
    # Create the grid
    x = np.linspace(xmin, xmax, nx)
    y = np.linspace(ymin, ymax, ny)
    X, Y = np.meshgrid(x, y)
    
    # Evaluate the function over the grid
    Z = func(X, Y)
    
    # Handle spacing
    if 'step_size' in config:
        z_min, z_max = np.min(Z), np.max(Z)
        start = np.floor(z_min / config['step_size']) * config['step_size']
        stop = np.ceil(z_max / config['step_size']) * config['step_size']
        levels = np.arange(start, stop + config['step_size'], config['step_size'])
    else:
        levels = config.get('levels', 15)
    
    # Generate contours in memory
    fig, ax = plt.subplots()
    contour_set = ax.contour(X, Y, Z, levels=levels)
    
    # Extract paths and write directly to CSV
    with open(filename, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        
        for path in contour_set.get_paths():
            vertices = path.vertices
            codes = path.codes
            
            # If a path has no codes, it's just a single continuous line
            if codes is None:
                row_data = vertices.flatten().tolist()
                if row_data:
                    writer.writerow(row_data)
                continue
                
            current_segment = []
            
            # Loop through vertices and look at drawing codes
            for vertex, code in zip(vertices, codes):
                # Code 1 means MOVETO (a brand new disconnected line starts here)
                if code == Path.MOVETO:
                    # If we were already tracking a line, save it before starting the new one
                    if current_segment:
                        writer.writerow(np.array(current_segment).flatten().tolist())
                    current_segment = [vertex]
                else:
                    # Code 2, 3, 4 mean LINETO or CURVETO (continue the current line)
                    current_segment.append(vertex)
            
            # Write the final remaining segment of this path
            if current_segment:
                writer.writerow(np.array(current_segment).flatten().tolist())
                    
    plt.close(fig)
    print(f"Success: Boundary-split contour data saved to '{filename}' using {len(levels)} levels.")

# ==========================================
# Example Usage
# ==========================================
if __name__ == "__main__":
    
    def sample_function(x, y):
        # 1. Taller Right Hill (Restored to your exact preferred settings)
        x_r, y_r = x - 1.0, y - 0.5
        hill_right = 2.0 * np.exp(-(0.12 * x_r**2 - 0.08 * x_r * y_r + 0.18 * y_r**2))
        
        # 2. Smaller Left Hill (Restored to your exact preferred settings)
        x_l, y_l = x + 1.5, y + 1.0
        hill_left = 1.2 * np.exp(-(0.15 * x_l**2 + 0.06 * x_l * y_l + 0.10 * y_l**2))
        
        # 3. NEW: Phantom Third Hill (Placed outside the top-left box at x=-6, y=6)
        # It's powerful (Amplitude 3.0) and wide, so its slope spills into your box,
        # creating a distinct valley/saddle between the two main hills.
        x_phantom, y_phantom = x + 6.0, y - 6.0
        hill_phantom = 3.0 * np.exp(-(0.10 * x_phantom**2 + 0.10 * y_phantom**2))
        
        # 4. Background Slope
        background_slope = 0.15 * x + 0.05 * y
        
        return hill_right + hill_left + hill_phantom + background_slope

    bounding_box = (-5.0, 5.0, -5.0, 5.0)

    configuration = {
        'nx': 300, 
        'ny': 300, 
        'step_size': 0.3 
    }

    export_contours_to_csv(
        func=sample_function, 
        box=bounding_box, 
        config=configuration, 
        filename="contours.csv"
    )
