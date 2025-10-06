/*
  # Dream 100 LinkedIn Outreach Database Schema

  1. New Tables
    - `dream_leads`
      - `id` (uuid, primary key)
      - `lead_name` (text)
      - `company` (text)
      - `industry` (text)
      - `lead_status` (text)
      - `connection_request_message` (boolean)
      - `connection_status` (boolean)
      - `dm1_timestamp` (timestamptz)
      - `dm_2` (boolean)
      - `dm_3` (boolean)
      - `booked_meeting` (boolean)
      - `notes` (text)
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)

  2. Security
    - Enable RLS on `dream_leads` table
    - Add policy for authenticated users to manage their leads
*/

CREATE TABLE IF NOT EXISTS dream_leads (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  lead_name text NOT NULL,
  company text NOT NULL,
  industry text DEFAULT '',
  lead_status text DEFAULT 'new',
  connection_request_message boolean DEFAULT false,
  connection_status boolean DEFAULT false,
  dm1_timestamp timestamptz,
  dm_2 boolean DEFAULT false,
  dm_3 boolean DEFAULT false,
  booked_meeting boolean DEFAULT false,
  notes text DEFAULT '',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE dream_leads ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage dream leads"
  ON dream_leads
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger to automatically update updated_at on changes
CREATE TRIGGER update_dream_leads_updated_at 
    BEFORE UPDATE ON dream_leads 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Insert sample data
INSERT INTO dream_leads (lead_name, company, industry, lead_status, connection_request_message, connection_status, dm1_timestamp, dm_2, dm_3, booked_meeting) VALUES
('John Smith', 'TechCorp Inc', 'Technology', 'active', true, true, now() - interval '3 days', false, false, false),
('Sarah Johnson', 'FinanceFlow', 'Finance', 'active', true, true, now() - interval '7 days', true, false, false),
('Mike Chen', 'DataDriven LLC', 'Analytics', 'qualified', true, true, now() - interval '12 days', true, true, false),
('Emily Davis', 'CloudSoft', 'Software', 'converted', true, true, now() - interval '15 days', true, true, true),
('Robert Wilson', 'StartupXYZ', 'Startup', 'new', false, false, null, false, false, false),
('Lisa Brown', 'MegaCorp', 'Enterprise', 'active', true, false, null, false, false, false),
('David Miller', 'InnovateNow', 'Innovation', 'active', true, true, now() - interval '5 days', false, false, false),
('Anna Garcia', 'GrowthCo', 'Marketing', 'qualified', true, true, now() - interval '10 days', true, false, false),
('James Taylor', 'ScaleUp Inc', 'Business', 'active', true, true, now() - interval '2 days', false, false, false),
('Jennifer Lee', 'NextGen Solutions', 'Technology', 'qualified', true, true, now() - interval '8 days', true, true, false);