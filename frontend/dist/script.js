// trigger the API from my API gateway
fetch('prod/counter') // relative pathing as the same proxy is used
  .then(response => response.json())
  .then(data => {
    const visitorCount = data.count;
    
    // Update the HTML element with the visitor count
    document.getElementById('visitorCountElement').textContent = visitorCount;
  })
  .catch(error => {
    console.error('Error:', error);
  });
