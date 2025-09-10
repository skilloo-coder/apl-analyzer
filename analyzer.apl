AnalyzeLog ← {
    logs ← ⎕NGET ⍵ 1
    lines ← logs[;1]

    ⍝ Split into tokens
    tokens ← ' '∘⎕CSV¨lines
    ips ← {⍵[1]}¨tokens
    codes ← {⍵[9]}¨tokens
    rawtimes ← {⍵[4]}¨tokens

    ⍝ Parse timestamps [10/Sep/2025:12:01:23
    clean ← {1↓⍵}¨rawtimes
    regex ← '\d{2}/\w{3}/\d{4}:\d{2}:\d{2}:\d{2}'
    parsed ← regex ⎕RE¨ clean
    times ← {⎕DT'YYYY-MM-DD hh:mm:ss' ⍵}¨ parsed[;0]

    ⍝ Bucketize by minute
    bucket ← ⌊times÷60

    ⍝ Failed logins
    fails ← ips / (codes='401')
    badIPs ← ∪fails

    ⍝ Spike detection (>=10/min)
    counts ← +/∘.=¨bucket
    spikes ← ips / (counts>10)
    spikeIPs ← ∪spikes

    ⍝ ---- Terminal Output ----
    ⎕← "🚨 APL Threat Report"
    ⎕← (⍴fails),' failed logins'
    ⎕← (⍴spikes),' spikes detected'
    :If ~0=⍴badIPs ⋄ ⎕← 'Failed login IPs: ',badIPs ⋄ :EndIf
    :If ~0=⍴spikeIPs ⋄ ⎕← 'Spike IPs: ',spikeIPs ⋄ :EndIf

    ⍝ ---- JSON Output ----
    json ← ⎕JSON (⎕NS⍬) ⎕NS⍬
    json.report_time ← ⎕TS
    json.failed_logins ← ⎕NS⍬
    json.failed_logins.count ← ⍴fails
    json.failed_logins.ips ← badIPs
    json.request_spikes ← ⎕NS⍬
    json.request_spikes.count ← ⍴spikes
    json.request_spikes.ips ← spikeIPs
    ⎕NPUT 'report.json' json

    ⍝ ---- CSV Output ----
    csv ← (('Failed Login',1⊃badIPs) ,/ (badIPs))
    :For ip :In spikeIPs
        csv ← csv , ('Request Spike',1,ip)
    :EndFor
    ⎕NPUT 'report.csv' csv

    ⎕← "✅ Reports generated: report.json, report.csv"
}
