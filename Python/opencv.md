# Open CV

## ROI

Image frame:
+----------------------------------------------+
|                                              |
|                                              |
|  (x1, y1)        w                           |
|         +----------------------+             |
|         |                      |             |
|         |                      |             |
|         |         ROI          | h           |
|         |                      |             |
|         |                      |             |
|         |                      |             |
|         +----------------------+             |
|                                (x2, y2)      |
|                                              |
|                                              |
|                                              |
+----------------------------------------------+
                                               (1280, 1024)

### Get ROI from image

```py
# Load the image
image = cv2.imread('\\\\Server_Name\\folder\\IMG_123456.jpg')
# Get ROI from image
roi = image[y1: y2, x1: x2]
```

### Detect image is light or dark color

```py
import cv2
import numpy as np

# Load the image
image = cv2.imread('\\\\Server_Name\\folder\\IMG_123456.jpg')

# Get ROI from image
roi = image[y1: y2, x1: x2]

# Convert to grayscale
gray = cv2.cvtColor(roi, cv2.COLOR_BGR2GRAY)

# Calculate the mean pixel intensity 
mean_intensity = np.mean(gray)
print(f"mean_intensity:{mean_intensity}")

# Define a threshold to classify as light or dark
threshold = 127 # This can be adjusted based on your specific needs

if mean_intensity > threshold:
    print("The image is predominantly light.")
else:
    print("The image is predominantly dark.")

# Apply a threshold to get binary image
# You can adjust the threshold value (127) to suit your needs
_, binary = cv2.threshold(gray, 127, 255, cv2.THRESH_BINARY)

# Display the result
cv2.imshow('Original Image', image)
cv2.imshow('Binary Image', binary)
cv2.waitKey(0)
cv2.destroyAllWindows()
```
