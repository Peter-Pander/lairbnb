// app/javascript/controllers/map_controller.js
import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    // Set the Mapbox API access token
    mapboxgl.accessToken = this.apiKeyValue

    // Initialize the Mapbox map
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    // Add markers to the map
    this.#addMarkersToMap()

    // Adjust the map bounds to fit the markers
    this.#fitMapToMarkers()
  }

  // Private method to add markers to the map
  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map)
    })
  }

  // Private method to adjust map bounds to fit all markers
  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()

    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))

    this.map.fitBounds(bounds, { padding: 70, maxZoom: 4, duration: 0 })
  }
}
