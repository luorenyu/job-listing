module JobsHelper
  def render_job_states(job)
    if job.is_hidden
      "（private）"
     else
      "（public）"
     end

  end
end
