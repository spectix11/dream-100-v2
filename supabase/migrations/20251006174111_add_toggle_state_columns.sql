/*
  # Add Toggle State Tracking Columns

  1. Changes
    - Add `connection_request_sent` column to track connection request status
    - Add `dm_2sent` column to track DM 2 sent status  
    - Add `dm_3sent` column to track DM 3 sent status
  
  2. Purpose
    - These columns persist the toggle states in the UI
    - Allow users to track outreach progress sequentially
    - State is remembered when switching between leads or refreshing
*/

ALTER TABLE dream_leads 
ADD COLUMN IF NOT EXISTS connection_request_sent boolean DEFAULT false,
ADD COLUMN IF NOT EXISTS dm_2sent boolean DEFAULT false,
ADD COLUMN IF NOT EXISTS dm_3sent boolean DEFAULT false;
