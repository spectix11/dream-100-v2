import { z } from 'zod';

export const leadSchema = z.object({
  lead_name: z.string().min(2, 'Name must be at least 2 characters'),
  lead_email: z.string().email('Invalid email address').optional().or(z.literal('')),
  lead_phone_number: z.string().optional(),
  job_title: z.string().optional(),
  lead_linkedin_url: z.string().url('LinkedIn URL is required and must be valid'),
});

export type LeadFormData = z.infer<typeof leadSchema>;