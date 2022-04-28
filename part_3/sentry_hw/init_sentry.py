import sentry_sdk
sentry_sdk.init(
    "https://39b91f7f9adb45cebe56e48ff479fbea@o1222932.ingest.sentry.io/6366997",

    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    traces_sample_rate=1.0
)

division_by_zero = 1 / 0