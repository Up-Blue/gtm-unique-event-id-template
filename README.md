  # Unique Event ID by Up Blue

  Custom GTM variable template that generates unique event IDs for deduplication between Meta Conversions API (CAPI) and GA4 browser-side events.

  ## Installation

  1. In Google Tag Manager, go to **Templates** > **Search Gallery**
  2. Search for **Unique Event ID by Up Blue**
  3. Click **Add to workspace**
  4. Create a new variable using this template

  ## How it works

  The template generates a unique identifier by combining three components:

  | Component | Description | Persistence |
  |-----------|-------------|-------------|
  | **Browser ID** | Timestamp + random number | Per browser session |
  | **Page Load ID** | Timestamp + random number | Per page load |
  | **Event ID** | GTM's `gtm.uniqueEventId` from dataLayer | Per event |

  ### Output format

  {browserId}_{pageLoadId}{eventId}

  Example: `1647430000000555555_164743000000055555542`

  ## Usage

  This variable is designed to be used as the **Event ID** parameter in both:

  - **Meta Pixel Tag** (browser-side) — pass this variable as the Event ID
  - **Meta Conversion API Tag** (server-side) — pass the same value via GA4 event parameter

  Meta uses the Event ID to deduplicate events received from both the browser Pixel and the server-side Conversions API, ensuring each conversion is counted only once.

  ### Typical setup

  1. Create a variable from this template (e.g., named `Unique Event ID`)
  2. In your **Meta Pixel Tag**, set the Event ID field to `{{Unique Event ID}}`
  3. Pass the same value to GA4 as a custom parameter (e.g., `event_id`)
  4. In your **server-side Meta CAPI Tag**, map `event_id` to the Event ID field

  ## Configuration

  This template requires **no configuration** — it works automatically out of the box.

  ## License

  Apache License 2.0 — see [LICENSE](LICENSE) for details.

  ## Author

  Built and maintained by [Up Blue](https://www.upblue.pl/).
