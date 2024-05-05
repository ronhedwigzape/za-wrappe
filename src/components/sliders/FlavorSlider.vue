<template>
    <div class="tw-relative tw-flex tw-w-full tw-max-h-[800px] tw-aspect-square">
        <SfScrollable
            ref="thumbsRef"
            class="tw-items-center tw-w-full [&::-webkit-scrollbar]:tw-hidden [-ms-overflow-style:none] [scrollbar-width:none]"
            direction="vertical"
            :active-index="activeIndex"
            :previous-disabled="startIndex === 0"
            :next-disabled="endIndex >= props.flavors.length"
            buttons-placement="floating"
            drag
        >
            <!-- Previous Button -->
            <template #previousButton="defaultProps">
                <SfButton
                    v-if="startIndex > 0"
                    v-bind="defaultProps"
                    @click="scrollPrevious"
                    class="tw-absolute !tw-rounded-full tw-z-10 tw-top-4 tw-rotate-90 tw-bg-white"
                    variant="secondary"
                    size="sm"
                    square
                >
                    <SfIconChevronLeft size="sm" />
                </SfButton>
            </template>

            <!-- Display 4 Visible Thumbnails -->
            <div
                v-for="(flavor, index) in visibleThumbnails"
                :key="`${flavor.name}-${startIndex + index}-thumbnail`"
                :aria-label="flavor.name"
                :aria-current="activeIndex === startIndex + index"
                @click="selectFlavor(flavor, startIndex + index)"
                @mouseover="activeIndex = startIndex + index"
                @focus="activeIndex = startIndex + index"
                class="tw-relative tw-type-button"
            >
                <img
                    :alt="flavor.name"
                    width="88"
                    height="88"
                    class="tw-border tw-border-neutral-200"
                    :src="`../img/${flavor.image_url}`"
                    :class="{
                'tw-bg-black tw-opacity-50 tw-border-2 tw-border-green-950': orderStore.selectedFlavor && orderStore.selectedFlavor.id === flavor.id
            }"
                />
                <div
                    v-if="orderStore.selectedFlavor && orderStore.selectedFlavor.id === flavor.id"
                    class="tw-absolute tw-inset-0 tw-flex tw-justify-center tw-items-center"
                >
                    <svg class="tw-w-6 tw-h-6 tw-text-green-800" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                    </svg>
                </div>
            </div>

            <!-- Next Button -->
            <template #nextButton="defaultProps">
                <SfButton
                    v-if="endIndex < props.flavors.length"
                    v-bind="defaultProps"
                    @click="scrollNext"
                    class="tw-absolute !tw-rounded-full tw-z-10 tw-bottom-4 tw-rotate-90 tw-bg-white"
                    variant="secondary"
                    size="sm"
                    square
                >
                    <SfIconChevronRight size="sm" />
                </SfButton>
            </template>
        </SfScrollable>
        <SfScrollable
            class="tw-w-full tw-h-full tw-snap-x tw-snap-mandatory [&::-webkit-scrollbar]:tw-hidden [-ms-overflow-style:none] [scrollbar-width:none]"
            :active-index="activeIndex"
            direction="vertical"
            wrapper-class="tw-h-full tw-m-auto"
            is-active-index-centered
            buttons-placement="none"
            :drag="{ containerWidth: true }"
            @on-drag-end="onDragged"
        >
            <div
                v-for="(flavor, index) in flavors"
                :key="`${flavor.name}-${index}`"
                @click="selectFlavor(flavor, index)"
                class="tw-flex tw-justify-center tw-h-full tw-basis-full tw-shrink-0 tw-grow tw-snap-center tw-relative"
            >
                <img
                    :aria-label="flavor.name"
                    :aria-hidden="activeIndex !== index"
                    :alt="flavor.name"
                    :class="[
                'tw-object-cover tw-w-auto tw-h-full',
                {
                    'tw-border-4 tw-border-primary-700 tw-opacity-50': orderStore.selectedFlavor && orderStore.selectedFlavor.id === flavor.id,
                }
            ]"
                    :src="`../img/${flavor.image_url}`"
                />
                <div
                    v-if="orderStore.selectedFlavor && orderStore.selectedFlavor.id === flavor.id"
                    class="tw-absolute tw-inset-0 tw-flex tw-justify-center tw-items-center"
                >
                    <svg class="tw-w-1/5 tw-h-1/5 tw-text-green-800" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                    </svg>
                </div>
                <div class="tw-absolute tw-bottom-0 tw-w-full tw-text-center tw-text-white tw-bg-black tw-bg-opacity-50 tw-py-2">
                    {{ flavor.name }}
                </div>
            </div>
        </SfScrollable>

    </div>
</template>

<script setup>
import {computed, ref, watch} from 'vue';
import {
    SfScrollable,
    SfButton,
    SfIconChevronLeft,
    SfIconChevronRight,
} from '@storefront-ui/vue';
import {useOrderStore} from "@/stores/store-order.js";
import { useIntersectionObserver, unrefElement } from '@vueuse/core';

const props = defineProps({
    flavors: Array
});

const orderStore = useOrderStore();
const thumbsRef = ref(null);
const firstThumbRef = ref(null);
const lastThumbRef = ref(null);
const firstThumbVisible = ref(false);
const lastThumbVisible = ref(false);
const activeIndex = ref(0);
const startIndex = ref(0);
const maxVisibleThumbnails = 4;

watch(
    thumbsRef,
    (newVal) => {
        if (newVal) {
            useIntersectionObserver(
                firstThumbRef,
                ([{ isIntersecting }]) => {
                    firstThumbVisible.value = isIntersecting;
                },
                {
                    root: unrefElement(thumbsRef),
                    rootMargin: '0px',
                    threshold: 1,
                },
            );
            useIntersectionObserver(
                lastThumbRef,
                ([{ isIntersecting }]) => {
                    lastThumbVisible.value = isIntersecting;
                },
                {
                    root: unrefElement(thumbsRef),
                    rootMargin: '0px',
                    threshold: 1,
                },
            );
        }
    },
    { immediate: true },
);

const endIndex = computed(() => Math.min(startIndex.value + maxVisibleThumbnails, props.flavors.length));
const visibleThumbnails = computed(() => props.flavors.slice(startIndex.value, endIndex.value));

const onDragged = ({ swipeRight, swipeLeft }) => {
    if (swipeRight && activeIndex.value > 0) {
        activeIndex.value -= 1;
    } else if (swipeLeft && activeIndex.value < props.flavors.length - 1) {
        activeIndex.value += 1;
    }
};

const assignRef = (el, index) => {
    if (!el) return;
    if (index === props.flavors.length - 1) {
        lastThumbRef.value = el;
    } else if (index === 0) {
        firstThumbRef.value = el;
    }
};

function thumbnailClass(flavor, index) {
    return [
        'md:tw-w-[78px] md:tw-h-auto tw-relative tw-shrink-0 tw-pb-1 tw-mx-4 -mb-2 tw-border-b-4 tw-snap-start tw-cursor-pointer focus-visible:tw-outline focus-visible:tw-outline-offset tw-transition-colors tw-flex-grow md:tw-flex-grow-0',
        {
            'tw-border-primary-700': activeIndex.value === index,
            'tw-opacity-50': !flavor.active
        }
    ];
}

function scrollNext() {
    if (startIndex.value + maxVisibleThumbnails < props.flavors.length) {
        startIndex.value += maxVisibleThumbnails;
    }
}

function scrollPrevious() {
    if (startIndex.value > 0) {
        startIndex.value = Math.max(startIndex.value - maxVisibleThumbnails, 0);
    }
}

// Select a flavor and update the active index
function selectFlavor(flavor, index) {
    orderStore.selectFlavor(flavor);
    activeIndex.value = index;
}
</script>
<style scoped>
.tw-type-button {
  overflow: hidden !important;
  max-width: 100% !important;
  max-height: 100% !important;
}

img {
  max-width: 100% !important;
  max-height: 100% !important;
  display: block !important;
}

</style>